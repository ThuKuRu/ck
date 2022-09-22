
<div class="box">
<div class="canvas">
    <form method="POST" onsubmit="return false;" id="formSignin">
        <p class="alert hidden"></p>
        <input type="text" id="user_signin" placeholder = "Username" autocomplete="on" name ="username" >
        <input type = "password" id="pass_signin" placeholder = "Password" name = "password">
        <input type="radio" id="hocsinhpick" name="typeaccount" value="hocsinh" required="required">
        <label for="hocsinh">Học Sinh</label>
        <input type="radio" id="giaovienpick" name="typeaccount" value="giaovien" required="required">
        <label for="giaovien">Giáo Viên</label>
        <button id="submit_signin">Sign In</button>
    </form>
</div>
</div>
