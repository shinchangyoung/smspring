<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
  #all, #me, #to {
    width: 100%;
    height: 300px;
    overflow-y: auto;
    border: 1px solid #ddd;
    padding: 10px;
    margin-bottom: 15px;
    display: flex;
    flex-direction: column;
    background-color: #f9f9f9;
  }



  /* 'Me' 채팅창의 하단 여백 제거 */
  #all, #me, #to  {
    margin-bottom: 0;
  }


  .message {
    margin-bottom: 10px;
    padding: 8px 12px;
    border-radius: 18px;
    max-width: 85%;
    word-wrap: break-word;
    display: flex;
    flex-direction: column;
  }

  .my-message {
    background-color: #dcf8c6;
    align-self: flex-end;
  }

  .other-message {
    background-color: #fff;
    border: 1px solid #e5e5e5;
    align-self: flex-start;
  }

  .sender-name {
    font-weight: bold;
    font-size: 0.8em;
    margin-bottom: 5px;
    color: #555;
  }

  .my-message .sender-name {
    align-self: flex-end;
  }

  .message-content {
    font-size: 0.95em;
  }
</style>

<script>
  let chat1 = {
    id: '',
    stompClient: null,
    init: function () {
      this.id = $('#user_id').text().trim();
      $('#connect').click(() => {
        this.connect();
      });
      $('#disconnect').click(() => {
        this.disconnect();
      });
      $('#sendall').click(() => {
        let msg = JSON.stringify({
          'sendid': this.id,
          'content1': $("#alltext").val()
        });
        this.stompClient.send("/receiveall", {}, msg);
        $("#alltext").val('');
      });
      $('#sendme').click(() => {
        let msg = JSON.stringify({
          'sendid': this.id,
          'content1': $("#metext").val()
        });
        this.stompClient.send("/receiveme", {}, msg);
        $("#metext").val('');
      });
      $('#sendto').click(() => {
        var msg = JSON.stringify({
          'sendid': this.id,
          'receiveid': $('#target').val(),
          'content1': $('#totext').val()
        });
        this.stompClient.send('/receiveto', {}, msg);
        $('#totext').val('');
      });
    },
    connect: function () {
      let sid = this.id;
      let socket = new SockJS('${websocketurl}chat');
      this.stompClient = Stomp.over(socket);
      this.setConnected(true);
      this.stompClient.connect({}, (frame) => {
        console.log('Connected: ' + frame);

        // For ALL Chat
        this.stompClient.subscribe('/send', (msg) => {
          let message = JSON.parse(msg.body);
          let senderId = message.sendid;
          let content = message.content1;
          let isMe = (senderId === sid);

          let messageDiv = $(`<div class="message"><div class="sender-name"></div><div class="message-content"></div></div>`);
          messageDiv.find('.message-content').text(content);

          if (isMe) {
            messageDiv.addClass('my-message');
            messageDiv.find('.sender-name').text('${sessionScope.cust.custName}');
          } else {
            messageDiv.addClass('other-message');
            messageDiv.find('.sender-name').text(senderId);
          }

          $("#all").append(messageDiv);
          $("#all").scrollTop($("#all")[0].scrollHeight);
        });

        // For ME Chat
        this.stompClient.subscribe('/send/' + sid, (msg) => {
          let message = JSON.parse(msg.body);
          let content = message.content1;

          let messageDiv = $(`<div class="message my-message"><div class="sender-name">${sessionScope.cust.custName}</div><div class="message-content"></div></div>`);
          messageDiv.find('.message-content').text(content);

          $("#me").append(messageDiv);
          $("#me").scrollTop($("#me")[0].scrollHeight);
        });

        // For TO Chat
        this.stompClient.subscribe('/send/to/' + sid, (msg) => {
          let message = JSON.parse(msg.body);
          let senderId = message.sendid;
          let content = message.content1;
          let isMe = (senderId === sid);

          let messageDiv = $(`<div class="message"><div class="sender-name"></div><div class="message-content"></div></div>`);
          messageDiv.find('.message-content').text(content);

          if (isMe) {
            messageDiv.addClass('my-message');
            messageDiv.find('.sender-name').text('${sessionScope.cust.custName}');
          } else {
            messageDiv.addClass('other-message');
            messageDiv.find('.sender-name').text(senderId);
          }

          $("#to").append(messageDiv);
          $("#to").scrollTop($("#to")[0].scrollHeight);
        });
      });
    },
    disconnect: function () {
      if (this.stompClient !== null) {
        this.stompClient.disconnect();
      }
      this.setConnected(false);
      console.log("Disconnected");
    },
    setConnected: function (connected) {
      if (connected) {
        $("#status").text("Connected");
      } else {
        $("#status").text("Disconnected");
      }
    }
  }

  $(() => {
    chat1.init();
  });
</script>

<div class="col-sm-10">
  <h2>Chat Center</h2>
  <div class="card-body">
    <h4 id="user_id" style="display: none;">${sessionScope.cust.custId}</h4>
    <p><b>Login ID:</b> ${sessionScope.cust.custId} | <b id="status" >Status</b></p>
    <button id="connect" class="btn btn-success btn-sm">Connect</button>
    <button id="disconnect" class="btn btn-danger btn-sm">Disconnect</button>
    <hr>

    <div class="row">
      <div class="col-md-6">
        <h3>모두에게 전송</h3>
        <div id="all"></div>
        <div class="input-group mb-3">
          <input type="text" id="alltext" class="form-control" placeholder="Message to all...">
          <div class="input-group-append">
            <button class="btn btn-primary" id="sendall">Send</button>
          </div>
        </div>
      </div>
      <div class="col-md-6">
        <h3>나에게만 전송</h3>
        <div id="me"></div>
        <div class="input-group mb-3" >
          <input type="text" id="metext" class="form-control" placeholder="Message to me...">
          <div class="input-group-append">
            <button class="btn btn-info" id="sendme">Send</button>
          </div>
        </div>
      </div>
    </div>

    <hr>

    <h3>1대1 채팅</h3>
    <div id="to"></div>
    <div class="input-group mb-3">
      <input type="text" id="target" class="form-control" placeholder="Recipient ID">
      <input type="text" id="totext" class="form-control" placeholder="Private message...">
      <div class="input-group-append">
        <button class="btn btn-warning" id="sendto">Send</button>
      </div>
    </div>
  </div>
</div>
