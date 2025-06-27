function sendOTP(){
    const email = document.getElementById('email');
    const otpverify = document.getElementsByClassName('otpverify')[0];

    let otp_val = Math.floor(Math.random()*10000);

    let emailbody = `
        <h1>Please Subscribe to Ash_is_Coding</h1> <br>
        <h2>Your OTP is </h2>${otp_val}
    `;

    Email.send({
        SecureToken : "add your code here",
        To : email.value,
        From : "your-email-created-in-smtpjs",
        Subject : "This is the from Ash_is_Coding, Please Subscribe",
        Body : emailbody
    }).then(
        //if success it returns "OK";
      message => {
        if(message === "OK"){
            alert("OTP sent to your email "+email.value);

            otpverify.style.display = "block";
            const otp_inp = document.getElementById('otp_inp');
            const otp_btn = document.getElementById('otp-btn');

            otp_btn.addEventListener('click',()=>{
                if(otp_inp.value == otp_val){
                    alert("Email address verified...");
                }
                else{
                    alert("Invalid OTP");
                }
            })
        }
      }
    );

}