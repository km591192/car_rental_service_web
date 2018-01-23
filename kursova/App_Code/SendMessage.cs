using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Net;
using System.Net.Mail;

/// <summary>
/// Сводное описание для SendMessage
/// </summary>
public class SendMessage
{
    public SendMessage()
    {
        //
        // TODO: добавьте логику конструктора
        //
    }

      public void SendEmail(string subject, string body)
{
    var fromAddress = new MailAddress("carrentcompanycrc@gmail.com");
    var toAddress = new MailAddress("kmkateryna@gmail.com");
    const string fromPassword = "CarRentCompanyCRC010190";
    

    var smtp = new SmtpClient
    {
        Host = "smtp.gmail.com",
        Port = 587,
        EnableSsl = true,
        DeliveryMethod = SmtpDeliveryMethod.Network,
        UseDefaultCredentials = false,
        Credentials = new NetworkCredential(fromAddress.Address, fromPassword)
    };
    using (var message = new MailMessage(fromAddress, toAddress)
    {
        Subject = subject,
        Body = body
    })
    {
        smtp.Send(message);
    }
}

}