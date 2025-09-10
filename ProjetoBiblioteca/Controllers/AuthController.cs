using Microsoft.AspNetCore.Mvc;
using ProjetoBiblioteca.Autenticacao;
using MySql.Data.MySqlClient;
using ProjetoBiblioteca.Data;

namespace ProjetoBiblioteca.Controllers
{
    public class AuthController : Controller
    {
        private readonly DataBase db = new DataBase();
        [HttpGet]
        public IActionResult Login(string? returnUrl = null)
        {
            ViewBag.ReturnUrl = returnUrl;
            return View();
        }
        [HttpPost, ValidateAntiForgeryToken]
        public IActionResult Login(string email, string senha, string? returnUrl = null)
        {
            if (string.IsNullOrWhiteSpace(email) || string.IsNullOrWhiteSpace(senha))
            {
                ViewBag.Error = "Informe e-email e senha. ";
                return View();
            }
            using var conn = db.GetConnection();
            using var cmd = new MySqlCommand("sp_usuario_obter_por_email", conn) { CommandType = System.Data.CommandType.StoredProcedure}
        }
    }
}
