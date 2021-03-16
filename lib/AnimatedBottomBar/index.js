const functions = require('firebase-functions');
 const admin=  require('firebase-admin');
 admin.initializeApp();
// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//  response.send("Hello from Firebase!");
// });
  exports.oncreateFollower = functions.firestore
  .document("/followers/{userId}/userFollowers/{followerId}")
  .onCreate(async(snapshot,context)=>{

const userId = context.params.userId;
const followerId = context.params.followerId;


const followedUserPostRef = admin.
firestore().collection('Posts')
.doc(userId).collection('Posts');




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


