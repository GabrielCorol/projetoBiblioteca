using Microsoft.AspNetCore.Mvc;
using MySql.Data.MySqlClient;
using ProjetoBiblioteca.Data;
using ProjetoBiblioteca.Models;

namespace ProjetoBiblioteca.Controllers
{
    public class GeneroController : Controller
    {
        public readonly Database db = new Database();
        public IActionResult Index()
        {
            return View();
        }
        public IActionResult CriarGenero()
        {
            return View();
        }
        [HttpPost]
        public IActionResult CriarGenero(Genero genero)
        {
            using var conn = db.GetConnection();
            using var cmd = new MySqlCommand("sp_genero_criar", conn);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("p_nome", genero.Nome);
            cmd.ExecuteNonQuery();
            return RedirectToAction("CriarGenero");
        }
    }
}
