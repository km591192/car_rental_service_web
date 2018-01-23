using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Net;
using System.Net.Mail;

/// <summary>
/// Сводное описание для MyWS
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// Чтобы разрешить вызывать веб-службу из скрипта с помощью ASP.NET AJAX, раскомментируйте следующую строку. 
// [System.Web.Script.Services.ScriptService]
public class MyWS : System.Web.Services.WebService
{

    public MyWS()
    {

        //Раскомментируйте следующую строку в случае использования сконструированных компонентов 
        //InitializeComponent(); 
    }
    [WebMethod]
    public DateTime[] GetDateTimes()
    {
        return new DateTime[] {
        DateTime.Now,
        DateTime.Now.ToLocalTime(),
        DateTime.Now.ToUniversalTime() };
    }

    [WebMethod]
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
