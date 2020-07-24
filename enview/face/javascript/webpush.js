/**
 * Step one: run a function on load (or whenever is appropriate for you)
 * Function run on load sets up the service worker if it is supported in the
 * browser. Requires a serviceworker in a `sw.js`. This file contains what will
 * happen when we receive a push notification.
 * If you are using webpack, see the section below.
 */
$(function () {
    if ('serviceWorker' in navigator) {
        navigator.serviceWorker.register('/sw.js').then(initialiseState);
    } else {
        console.warn('Service workers are not supported in this browser.');
    }
});

/**
 * Step two: The serviceworker is registered (started) in the browser. Now we
 * need to check if push messages and notifications are supported in the browser
 */
function initialiseState() {

    // Check if desktop notifications are supported
    if (!('showNotification' in ServiceWorkerRegistration.prototype)) {
        console.warn('Notifications aren\'t supported.');
        return;
    }

    // Check if user has disabled notifications
    // If a user has manually disabled notifications in his/her browser for 
    // your page previously, they will need to MANUALLY go in and turn the
    // permission back on. In this statement you could show some UI element 
    // telling the user how to do so.
    if (Notification.permission === 'denied') {
        console.warn('The user has blocked notifications.');
        return;
    }

    // Check is push API is supported
    if (!('PushManager' in window)) {
        console.warn('Push messaging isn\'t supported.');
        return;
    }

    navigator.serviceWorker.ready.then(function (serviceWorkerRegistration) {

        // Get the push notification subscription object
        serviceWorkerRegistration.pushManager.getSubscription().then(function (subscription) {

            // If this is the user's first visit we need to set up
            // a subscription to push notifications
            if (!subscription) {
                subscribe();

                return;
            }

            // Update the server state with the new subscription
            // sendSubscriptionToServer(subscription);
        })
        .catch(function(err) {
            // Handle the error - show a notification in the GUI
            console.warn('Error during getSubscription()', err);
        });
    });
}

/**
 * Step three: Create a subscription. Contact the third party push server (for
 * example mozilla's push server) and generate a unique subscription for the
 * current browser.
 */
function subscribe() {
	
    navigator.serviceWorker.ready.then(function (serviceWorkerRegistration) {

        // Contact the third party push server. Which one is contacted by
        // pushManager is  configured internally in the browser, so we don't
        // need to worry about browser differences here.
        //
        // When .subscribe() is invoked, a notification will be shown in the
        // user's browser, asking the user to accept push notifications from
        // <yoursite.com>. This is why it is async and requires a catch.
    	const applicationServerKey = urlB64ToUint8Array(webPushPublicKey);
    	serviceWorkerRegistration.pushManager.subscribe({userVisibleOnly: true, applicationServerKey: applicationServerKey}).then(function (subscription) {

            // Update the server state with the new subscription
            return sendSubscriptionToServer(subscription);
        })
        .catch(function (e) {
            if (Notification.permission === 'denied') {
                console.warn('Permission for Notifications was denied');
            } else {
                console.error('Unable to subscribe to push.', e);
            }
        });
    });
}

/**
 * Step four: Send the generated subscription object to our server.
 */
function sendSubscriptionToServer(subscription) {
	var url = "/user/updatePushToken.face";
	var pushToken = JSON.stringify(subscription);
	var param = { pushToken : pushToken};
	
    $.ajax({
        url: url,
        type:'post',
        data:param,
        dataType : 'json',
        success:function(data){
        	alert( JSON.stringify(data));
        },
        error:function(request,status,error) {
            alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
       }
    });
}

function urlB64ToUint8Array(base64String) {
	  const padding = '='.repeat((4 - base64String.length % 4) % 4);
	  const base64 = (base64String + padding)
	    .replace(/\-/g, '+')
	    .replace(/_/g, '/');

	  const rawData = window.atob(base64);
	  const outputArray = new Uint8Array(rawData.length);

	  for (let i = 0; i < rawData.length; ++i) {
	    outputArray[i] = rawData.charCodeAt(i);
	  }
	  return outputArray;
	}

