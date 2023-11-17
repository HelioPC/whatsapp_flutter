const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

const firestore = admin.firestore();

exports.onUserStatusChange = functions.database.ref("/{uid}/active").onUpdate(
    async (change, context) => {
        // Get data from realtime database
        const isActive = change.after.val();
        // Get reference to cloud firestore doc
        const firestoreRef = firestore.doc(`users/${context.params.uid}`);

        return firestoreRef.update({
            active: isActive,
            lastSeen: Date.now(),
        });
    }
);
