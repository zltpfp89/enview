/*
*
*  Push Notifications codelab
*  Copyright 2015 Google Inc. All rights reserved.
*
*  Licensed under the Apache License, Version 2.0 (the "License");
*  you may not use this file except in compliance with the License.
*  You may obtain a copy of the License at
*
*      https://www.apache.org/licenses/LICENSE-2.0
*
*  Unless required by applicable law or agreed to in writing, software
*  distributed under the License is distributed on an "AS IS" BASIS,
*  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
*  See the License for the specific language governing permissions and
*  limitations under the License
*
*/

/* eslint-env browser, es6 */

'use strict';
//const webPushPublicKey = 'BOWHgE-JLePrESKxmwoC-d77pkBQHk62WVwS4qgJyjKXf6CV3O5owh7rbyeDmQrLTeyJtjZYK3RPZ7Y-K6gIiD8';

if ('serviceWorker' in navigator && 'PushManager' in window) {
	  console.log('서비스워커와 푸시가 지원됩니다.');

	  navigator.serviceWorker.register('/sw.js',)
	  .then(function(swReg) {
	    console.log('서비스워커가 등록되었습니다.', swReg);

	    swRegistration = swReg;
		initialiseUI();
	  })
	  .catch(function(error) {
	    console.error('서비스워커 오류입니다.', error);
	  });
	} else {
	  console.warn('푸시메시지가 지원되지 않습니다.');
	  pushButton.textContent = '푸시가 지원되지 않습니다.';
	}



const pushButton = document.querySelector('.js-push-btn');

let isSubscribed = false;
let swRegistration = null;

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


function initialiseUI() {
  pushButton.addEventListener('click', function() {
    pushButton.disabled = true;
    if (isSubscribed) {
      // TODO: Unsubscribe user
    } else {
      subscribeUser();
    }
  });

  // Set the initial subscription value
  swRegistration.pushManager.getSubscription()
  .then(function(subscription) {
    isSubscribed = !(subscription === null);

    if (isSubscribed) {
      console.log('사용자가 등록되었습니다.');
    } else {
      console.log('사용자가 등록되지 않았습니다.');
    }

    updateBtn();
  });
}

function updateBtn() {

  if (Notification.permission === 'denied') {
    pushButton.textContent = '푸시메시징이 차단되었습니다..';
    pushButton.disabled = true;
    updateSubscriptionOnServer(null);
    return;
  }


  if (isSubscribed) {
    pushButton.textContent = '푸시메시징 중지';
  } else {
    pushButton.textContent = '푸시메시징 사용';
  }
  pushButton.disabled = false;
}


function subscribeUser() {
  const applicationServerKey = urlB64ToUint8Array(webPushPublicKey);
  swRegistration.pushManager.subscribe({
    userVisibleOnly: true,
    applicationServerKey: applicationServerKey
  })
  .then(function(subscription) {
    console.log('사용자가 등록되었습니다. :', subscription);

    updateSubscriptionOnServer(subscription);

    isSubscribed = true;

    updateBtn();
  })
  .catch(function(err) {
    console.log('사용자를 등록하는데 실패했습니다.: ', err);
    updateBtn();
  });
}

function updateSubscriptionOnServer(subscription) {
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

