const functions = require('firebase-functions');
 const admin=  require('firebase-admin');

 admin.initializeApp();

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//  response.send("Hello from Firebase!");
// });
  exports.oncreateFollower = functions.region('asia-east2').firestore
  .document("/Follower/{userId}/userFollowers/{followerId}")
  .onCreate(async(snapshot,context)=>{

const userId = context.params.userId;
const followerId = context.params.followerId;


const followedUserPostRef = admin.
firestore().collection('Post')
.doc(userId).collection('Post');




const timelinePostsRef = admin
.firestore()
.collection('timeline')
.doc(followerId).collection('timelinePosts');


const querySnapshot = await followedUserPostRef.get();

querySnapshot.forEach(doc=>{

if(doc.exists){
const postId = doc.id;
const postData = doc.data();

timelinePostsRef.doc(postId).set(postData); 


}

})
  });




  exports.onDeleteFollower = functions.region('asia-east2').
  firestore.document("/Follower/{userId}/userFollowers/{followerId}").
  onDelete(async(snapshot,context)=>{

    const userId = context.params.userId;
    const followerId = context.params.followerId;
 

const timelinePostsRef = admin
.firestore()
.collection('timeline')
.doc(followerId).collection('timelinePosts').where('ownerId',"==",userId);

const querySnapshot = await timelinePostsRef.get();

querySnapshot.forEach(doc =>{

    if(doc.exists){ 

doc.ref.delete();
    }
});



    
  });



  exports.onCreatePost =  functions.region('asia-east2').firestore
  .document("/Post/{vendorId}/Post/{postId}")
  .onCreate(async(snapshot,context)=>{

  const postCreated = snapshot.data();
  const userId = context.params.vendorId;
  const postId = context.params.postId;

  const vendorFollowersRef = admin.firestore().collection('Follower')
  .doc(userId)
  .collection('userFollowers');

  const querySnapshot = await vendorFollowersRef.get();


  querySnapshot.forEach(doc =>{

   const followerId = doc.id;

   admin.firestore().collection('timeline')
   .doc(followerId)
   .collection('timelinePosts')
   .doc(postId).set(postCreated);

  });


  });

  exports.onUpdatePost = functions.region('asia-east2').firestore.document("/Post/{vendorId}/Post/{postId}")
  .onUpdate(async(change,context)=>{

    const postUpdated = change.after.data();
    const userId = context.params.vendorId;
    const postId = context.params.postId;
  
  
    const vendorFollowersRef = admin.firestore().collection('Follower')
    .doc(userId)
    .collection('userFollowers');
    const querySnapshot = await vendorFollowersRef.get();


    querySnapshot.forEach(doc =>{

      const followerId = doc.id;
   
      admin.firestore().collection('timeline')
      .doc(followerId)
      .collection('timelinePosts')
      .doc(postId).get().then(doc=>{

     if(doc.exists){

      doc.ref.update(postUpdated);

     }

      });
   
     });
  });


  exports.onDeletePost = functions.region('asia-east2').firestore
  .document("/Post/{vendorId}/Post/{postId}")
  .onDelete(async(snapshot,context)=>{


    const userId = context.params.vendorId;
    const postId = context.params.postId;


    const vendorFollowersRef = admin.firestore().collection('Follower')
    .doc(userId)
    .collection('userFollowers');

    const querySnapshot = await vendorFollowersRef.get();

    querySnapshot.forEach(doc =>{

      const followerId = doc.id;
   
      admin.firestore().collection('timeline')
      .doc(followerId)
      .collection('timelinePosts')
      .doc(postId).get().then(doc=>{

     if(doc.exists){

      doc.ref.delete();

     }

      });
   
     });
   

  });


//   exports.sendUserMail = functions.region('asia-east2').firestore.document('/order_stitching/{userId}/orders_stitching/{orderId}').onCreate((snap,cont)=>{
//  const nodemailer = require('nodemailer');

//     const data = snap.data();


// let authdata = nodemailer.createTransport({

// service:'gmail',
// auth:{

//   user:'canable.app@gmail.com',
//   pass:'rampur123$'
// }

// });

// authdata.sendMail({
//   from:'Canable.app@gmail.com',
  
//   to :'canable.app@gmail.com',
//   subject:'Order Confirmed',
//   text:'New order Recieved',
//   html:'OrderId : '+data.ProductId+ ' from : '+data.seller+ ' CustomerName : ' +data.Name +' Price : ' +data.price
  
  
  
  
//   });

//   });

  exports.onOrder = functions.region('asia-east2').firestore.document("/V_orders/{vendorId}/orders/{orderId}").onCreate(async(snapshot,context)=>{

const fcm =admin.messaging();

const vendorId = context.params.vendorId;
const orderId = context.params.orderId;
const orderDoc = snapshot.data();
const vendorDoc = await admin.firestore().collection('Vendors').doc(vendorId).get();

const token = vendorDoc.data().fcmToken;


const payload = {
  notification: {
   

  title:'New Order Received!',
  body: 'Product Sold worth Rs ' +orderDoc['price'] ,
  clickAction:'FLUTTER_NOTIFICATION_CLICK'
  }
};



return fcm.sendToDevice(token,payload);
  });



exports.onNewMesssage = functions.region('asia-east2').firestore.document("/conversations/{conversationId}/conversations/{messageId}").onCreate(async(snapshot,context)=>{

  const fcm =admin.messaging();


const messageData = snapshot.data();

const userData = await admin.firestore().collection('Users').doc(messageData['receiverId']).get();

const token = userData.data().fcmToken;
const user = userData.data();
const payload = {
  notification: {
   

  title: messageData['sendersName'],
  body: messageData['message'] ,
  clickAction:'FLUTTER_NOTIFICATION_CLICK'
  }
};



return fcm.sendToDevice(token,payload);

});




  exports.activityNotifi = functions.region('asia-east2').firestore.document("/activity/{vendorId}/activity/{activityId}").onCreate(async(snapshot,context)=>{

    const fcm =admin.messaging();
    
    const vendorId = context.params.vendorId;
    const activityId = context.params.activityId;
    const activityDoc = snapshot.data();
    const vendorDoc = await admin.firestore().collection('Vendors').doc(vendorId).get();
    
    const token = vendorDoc.data().fcmToken;
    
    
    const payload = {
      notification: {
       
    
      title:activityDoc['userName'],
      body: activityDoc['message'],
      clickAction:'FLUTTER_NOTIFICATION_CLICK'
      }
    };
    
    
    
    return fcm.sendToDevice(token,payload);
      });


      exports.onuserSignup = functions.region('asia-east2').auth.user().onCreate(user =>{


const sgmail  = require('@sendgrid/mail');

sgmail.setApiKey('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');

const massage = {

  to :user.email,
  from :'canable.app@gmail.com',
  templateId:'d-f08ad6be92024e5c9dd9fd0530a4bfaf',
  dynamic_template_data:{

    name:user.displayName
  }
}
return sgmail.send(massage);
      });
      exports.onOrderStitching = functions.region('asia-east2').firestore.document("/order_stitching/{userId}/orders_stitching/{orderId}").onCreate(async(snapshot,context) =>{


        const sgmail  = require('@sendgrid/mail');
        const activityDoc = snapshot.data();
        sgmail.setApiKey('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');
        if(snapshot.data()['type']=='salwarSuit'){

          const massage = {
        
            to :snapshot.data()['userEmail'],
            from :'canable.app@gmail.com',
            templateId:'d-f77becf78c6543b4aface50c4fb01962',
            dynamic_template_data:{
              userName:snapshot.data()['userDisplayName'],
              orderId:snapshot.data()['orderId'],
              typeDisplay:snapshot.data()['typeDisplay'],
              fabricUrl:snapshot.data()['fabricImage'],
              price:snapshot.data()['price']
              
                          }
          }
          return sgmail.send(massage);

        }
        else  if(snapshot.data()['type']=='Frock'){

          const massage = {
        
            to :snapshot.data()['userEmail'],
            from :'canable.app@gmail.com',
            templateId:'d-f77becf78c6543b4aface50c4fb01962',
            dynamic_template_data:{
              userName:snapshot.data()['userDisplayName'],
              orderId:snapshot.data()['orderId'],
              typeDisplay:snapshot.data()['typeDisplay'],
              fabricUrl:snapshot.data()['fabricImage'],
              price:snapshot.data()['price']
              
                          }
          }
          return sgmail.send(massage);

        }
        else  if(snapshot.data()['type']=='blouse'){

          const massage = {
        
            to :snapshot.data()['userEmail'],
            from :'canable.app@gmail.com',
            templateId:'d-f77becf78c6543b4aface50c4fb01962',
            dynamic_template_data:{
              userName:snapshot.data()['userDisplayName'],
              orderId:snapshot.data()['orderId'],
              typeDisplay:snapshot.data()['typeDisplay'],
              fabricUrl:snapshot.data()['fabricImage'],
              price:snapshot.data()['price']
              
                          }
          }
          return sgmail.send(massage);

        }
        else  if(snapshot.data()['type']=='lehenga'){

          const massage = {
        
            to :snapshot.data()['userEmail'],
            from :'canable.app@gmail.com',
            templateId:'d-f77becf78c6543b4aface50c4fb01962',
            dynamic_template_data:{
              userName:snapshot.data()['userDisplayName'],
              orderId:snapshot.data()['orderId'],
              typeDisplay:snapshot.data()['typeDisplay'],
              fabricUrl:snapshot.data()['fabricImage'],
              price:snapshot.data()['price']
              
                          }
          }
          return sgmail.send(massage);

        }else  if(snapshot.data()['type']=='garara'){

          const massage = {
        
            to :snapshot.data()['userEmail'],
            from :'canable.app@gmail.com',
            templateId:'d-f77becf78c6543b4aface50c4fb01962',
            dynamic_template_data:{
              userName:snapshot.data()['userDisplayName'],
              orderId:snapshot.data()['orderId'],
              typeDisplay:snapshot.data()['typeDisplay'],
              fabricUrl:snapshot.data()['fabricImage'],
              price:snapshot.data()['price']
              
                          }
          }
          return sgmail.send(massage);

        }
        else if(snapshot.data()['type']=='Pakistani Stitching'){


 const massage = {
        
            to :snapshot.data()['userEmail'],
            from :'canable.app@gmail.com',
            templateId:'d-bb4a3371d3a14a0b86d9c2d73e4dd1cf',
            dynamic_template_data:{
userName:snapshot.data()['userDisplayName'],
orderId:snapshot.data()['orderId'],
fabricUrl:snapshot.data()['fabricImage'],
designUrl:snapshot.data()['designImage'],
price:snapshot.data()['price']

            }
          }
          return sgmail.send(massage);

        }
        else if(snapshot.data()['type']=='Send Your Design'){


          const massage = {
                 
                     to :snapshot.data()['userEmail'],
                     from :'canable.app@gmail.com',
                     templateId:'d-55016a23358c4895abf997e4b721e4d9',
                     dynamic_template_data:{
         userName:snapshot.data()['userDisplayName'],
         fabricUrl:snapshot.data()['fabricImage'],
         designUrl:snapshot.data()['designImage'],
        
         
                     }
                   }
                   return sgmail.send(massage);
         
                 }
       
              });



              exports.onOrderStitchingUpdate = functions.region('asia-east2').firestore.document("/order_stitching/{userId}/orders_stitching/{orderId}").onUpdate(async(change,context) =>{
                const postUpdated = change.after.data();


                const sgmail  = require('@sendgrid/mail');
                sgmail.setApiKey('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');
                if(postUpdated['type']=='salwarSuit'){
        if(postUpdated['status']=='delivered'){

          const massage = {
                
            to :postUpdated['userEmail'],
            from :'canable.app@gmail.com',
            templateId:'d-24d69bb414864a4b820a1d26c9e1caee',
            dynamic_template_data:{
              userName:postUpdated['userDisplayName'],
              orderId:postUpdated['orderId'],
              typeDisplay:postUpdated['typeDisplay'],
              fabricUrl:postUpdated['fabricImage'],
              price:postUpdated['price']
              
                          }
          }
          return sgmail.send(massage);

        }
                
        
                }
                else  if(postUpdated['type']=='Frock'){
                  if(postUpdated['status']=='delivered'){
          
                    const massage = {
                          
                      to :postUpdated['userEmail'],
                      from :'canable.app@gmail.com',
                      templateId:'d-24d69bb414864a4b820a1d26c9e1caee',
                      dynamic_template_data:{
                        userName:postUpdated['userDisplayName'],
                        orderId:postUpdated['orderId'],
                        typeDisplay:postUpdated['typeDisplay'],
                        fabricUrl:postUpdated['fabricImage'],
                        price:postUpdated['price']
                        
                                    }
                    }
                    return sgmail.send(massage);
          
                  }
                          
                  
                          }
                else  if(postUpdated['type']=='Send Your Design'){
                  if(postUpdated['status']=='delivered'){
          
                    const massage = {
                          
                      to :postUpdated['userEmail'],
                      from :'canable.app@gmail.com',
                      templateId:'d-b4fe6e83bebf40e2ad14c70748a990e1',
                      dynamic_template_data:{
                        userName:postUpdated['userDisplayName'],
                        orderId:postUpdated['orderId'],
                        fabricUrl:postUpdated['fabricImage'],
                        designUrl:postUpdated['designImage'],

                        price:postUpdated['price']
                        
                                    }
                    }
                    return sgmail.send(massage);
          
                  }
                  else if(postUpdated['status']=='In Progress'){
          
                    const massage = {
                          
                      to :postUpdated['userEmail'],
                      from :'canable.app@gmail.com',
                      templateId:'d-14502ce3591d48ecab8c34b13282567d',
                      dynamic_template_data:{
                        userName:postUpdated['userDisplayName'],
                        orderId:postUpdated['orderId'],
                        fabricUrl:postUpdated['fabricImage'],
                        designUrl:postUpdated['designImage'],

                        price:postUpdated['price']
                        
                                    }
                    }
                    return sgmail.send(massage);
          
                  }
                          
                  
                          }
                          else  if(postUpdated['type']=='Pakistani Stitching'){
                            if(postUpdated['status']=='delivered'){
                    
                              const massage = {
                                    
                                to :postUpdated['userEmail'],
                                from :'canable.app@gmail.com',
                                templateId:'d-e370baefdc23442f8edbe2695ac852f4',
                                dynamic_template_data:{
                                  userName:postUpdated['userDisplayName'],
                                  orderId:postUpdated['orderId'],
                                  fabricUrl:postUpdated['fabricImage'],
                                  designUrl:postUpdated['designImage'],
          
                                  price:postUpdated['price']
                                  
                                              }
                              }
                              return sgmail.send(massage);
                    
                            }
                                    
                            
                                    }
               
                      });







                      exports.onOrderStitching_canable = functions.region('asia-east2').firestore.document("/order_stitching/{userId}/orders_stitching/{orderId}").onCreate(async(snapshot,context) =>{


                        const sgmail  = require('@sendgrid/mail');
                        const activityDoc = snapshot.data();
                        sgmail.setApiKey('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');
                        if(snapshot.data()['type']=='salwarSuit'){
                
                          const massage = {
                        
                            to :'canable.app@gmail.com',
                            from :'canable.app@gmail.com',
                            templateId:'d-8828a013df184e3690f9339fd6838bfb',
                            dynamic_template_data:{
                userDisplayName:snapshot.data()['userDisplayName'],
                fabricImage:snapshot.data()['fabricImage'],
                price:snapshot.data()['price'],
                name:snapshot.data()['name'],
                phone:snapshot.data()['phone'],
                address:snapshot.data()['address'],
                orderId:snapshot.data()['orderId'],
                city:snapshot.data()['city'],
                userEmail:snapshot.data()['userEmail'],
                timeStamp:snapshot.data()['timeStamp'],
                notes:snapshot.data()['notes'],
                userId:snapshot.data()['userId'],
                topAstar:snapshot.data()['topAstar'],
                bottomAstar:snapshot.data()['bottomAstar'],
                plan:snapshot.data()['plan'],
                status:snapshot.data()['status'],
                type:snapshot.data()['type']
                              
                                          }
                          }
                          return sgmail.send(massage);
                
                        }
                        else if(snapshot.data()['type']=='blouse'){
                
                
                          const massage = {
                                 
                                 
                            to :'canable.app@gmail.com',
                            from :'canable.app@gmail.com',
                            templateId:'d-8828a013df184e3690f9339fd6838bfb',
                            dynamic_template_data:{
                userDisplayName:snapshot.data()['userDisplayName'],
                fabricImage:snapshot.data()['fabricImage'],
                price:snapshot.data()['price'],
                name:snapshot.data()['name'],
                phone:snapshot.data()['phone'],
                address:snapshot.data()['address'],
                orderId:snapshot.data()['orderId'],
                city:snapshot.data()['city'],
                userEmail:snapshot.data()['userEmail'],
                timeStamp:snapshot.data()['timeStamp'],
                notes:snapshot.data()['notes'],
                userId:snapshot.data()['userId'],
                topAstar:snapshot.data()['topAstar'],
                bottomAstar:snapshot.data()['bottomAstar'],
                plan:snapshot.data()['plan'],
                status:snapshot.data()['status'],
                type:snapshot.data()['type']
         
                         
                                     }
                                   }
                                   return sgmail.send(massage);
                         
                                 }
                        else if(snapshot.data()['type']=='Frock'){
                
                
                          const massage = {
                                 
                                 
                            to :'canable.app@gmail.com',
                            from :'canable.app@gmail.com',
                            templateId:'d-8828a013df184e3690f9339fd6838bfb',
                            dynamic_template_data:{
                userDisplayName:snapshot.data()['userDisplayName'],
                fabricImage:snapshot.data()['fabricImage'],
                price:snapshot.data()['price'],
                name:snapshot.data()['name'],
                phone:snapshot.data()['phone'],
                address:snapshot.data()['address'],
                orderId:snapshot.data()['orderId'],
                city:snapshot.data()['city'],
                userEmail:snapshot.data()['userEmail'],
                timeStamp:snapshot.data()['timeStamp'],
                notes:snapshot.data()['notes'],
                userId:snapshot.data()['userId'],
                topAstar:snapshot.data()['topAstar'],
                bottomAstar:snapshot.data()['bottomAstar'],
                plan:snapshot.data()['plan'],
                status:snapshot.data()['status'],
                type:snapshot.data()['type']
         
                         
                                     }
                                   }
                                   return sgmail.send(massage);
                         
                                 } else if(snapshot.data()['type']=='lehenga'){
                
                
                                  const massage = {
                                         
                                         
                                    to :'canable.app@gmail.com',
                                    from :'canable.app@gmail.com',
                                    templateId:'d-8828a013df184e3690f9339fd6838bfb',
                                    dynamic_template_data:{
                        userDisplayName:snapshot.data()['userDisplayName'],
                        fabricImage:snapshot.data()['fabricImage'],
                        price:snapshot.data()['price'],
                        name:snapshot.data()['name'],
                        phone:snapshot.data()['phone'],
                        address:snapshot.data()['address'],
                        orderId:snapshot.data()['orderId'],
                        city:snapshot.data()['city'],
                        userEmail:snapshot.data()['userEmail'],
                        timeStamp:snapshot.data()['timeStamp'],
                        notes:snapshot.data()['notes'],
                        userId:snapshot.data()['userId'],
                        topAstar:snapshot.data()['topAstar'],
                        bottomAstar:snapshot.data()['bottomAstar'],
                        plan:snapshot.data()['plan'],
                        status:snapshot.data()['status'],
                        type:snapshot.data()['type']
                 
                                 
                                             }
                                           }
                                           return sgmail.send(massage);
                                 
                                         } else if(snapshot.data()['type']=='garara'){
                
                
                                          const massage = {
                                                 
                                                 
                                            to :'canable.app@gmail.com',
                                            from :'canable.app@gmail.com',
                                            templateId:'d-8828a013df184e3690f9339fd6838bfb',
                                            dynamic_template_data:{
                                userDisplayName:snapshot.data()['userDisplayName'],
                                fabricImage:snapshot.data()['fabricImage'],
                                price:snapshot.data()['price'],
                                name:snapshot.data()['name'],
                                phone:snapshot.data()['phone'],
                                address:snapshot.data()['address'],
                                orderId:snapshot.data()['orderId'],
                                city:snapshot.data()['city'],
                                userEmail:snapshot.data()['userEmail'],
                                timeStamp:snapshot.data()['timeStamp'],
                                notes:snapshot.data()['notes'],
                                userId:snapshot.data()['userId'],
                                topAstar:snapshot.data()['topAstar'],
                                bottomAstar:snapshot.data()['bottomAstar'],
                                plan:snapshot.data()['plan'],
                                status:snapshot.data()['status'],
                                type:snapshot.data()['type']
                         
                                         
                                                     }
                                                   }
                                                   return sgmail.send(massage);
                                         
                                                 }
                        else if(snapshot.data()['type']=='Pakistani Stitching'){
                
                
                 const massage = {
                        
                            to :'canable.app@gmail.com',
                            from :'canable.app@gmail.com',
                            templateId:'d-8828a013df184e3690f9339fd6838bfb',
                            dynamic_template_data:{
                userDisplayName:snapshot.data()['userDisplayName'],
                fabricImage:snapshot.data()['fabricImage'],
                designImage:snapshot.data()['designImage'],
                price:snapshot.data()['price'],
                name:snapshot.data()['name'],
                phone:snapshot.data()['phone'],
                address:snapshot.data()['address'],
                orderId:snapshot.data()['orderId'],
                city:snapshot.data()['city'],
                userEmail:snapshot.data()['userEmail'],
                timeStamp:snapshot.data()['timeStamp'],
                notes:snapshot.data()['notes'],
                userId:snapshot.data()['userId'],
                topAstar:snapshot.data()['topAstar'],
                bottomAstar:snapshot.data()['bottomAstar'],
                plan:snapshot.data()['plan'],
                status:snapshot.data()['status'],
                type:snapshot.data()['type']


                
                            }
                          }
                          return sgmail.send(massage);
                
                        }
                        else if(snapshot.data()['type']=='Send Your Design'){
                
                
                          const massage = {
                                 
                                     to :'canable.app@gmail.com',
                                     from :'canable.app@gmail.com',
                                     templateId:'d-0d409d98bc3f41188b2a2a96c9cde648',
                                     dynamic_template_data:{
                                      userDisplayName:snapshot.data()['userDisplayName'],
                                      fabricImage:snapshot.data()['fabricImage'],
                                      designImage:snapshot.data()['designImage'],
                                      name:snapshot.data()['name'],
                                      phone:snapshot.data()['phone'],
                                      address:snapshot.data()['address'],
                                      orderId:snapshot.data()['orderId'],
                                      city:snapshot.data()['city'],
                                      userEmail:snapshot.data()['userEmail'],
                                      timeStamp:snapshot.data()['timeStamp'],
                                      notes:snapshot.data()['notes'],
                                      userId:snapshot.data()['userId'],
      
                                      status:snapshot.data()['status'],
                                      type:snapshot.data()['type']
                        
                         
                                     }
                                   }
                                   return sgmail.send(massage);
                         
                                 }
                       
                              });
                
                
                