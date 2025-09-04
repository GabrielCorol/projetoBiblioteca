using Microsoft.AspNetCore.Mvc;
using MySql.Data.MySqlClient;
using ProjetoBiblioteca.Data;
using ProjetoBiblioteca.Models;

namespace ProjetoBiblioteca.Controllers
{
    public class EditoraController : Controller
    {
        public readonly Database db = new Database();
        public IActionResult Index()
        {
            return View();
        }
        public IActionResult CriarEditora()
        {
            return View();
        }
        [HttpPost]
        public IActionResult CriarEditora(Editora editora)
        {
            using var conn = db.GetConnection();
            using var cmd = new MySqlCommand("sp_editora_criar", conn);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("p_nome", editora.Nome);
            cmd.ExecuteNonQuery();
            return RedirectToAction("CriarEditora");
        }
    }
}
