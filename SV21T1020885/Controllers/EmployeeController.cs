using Microsoft.AspNetCore.Mvc;
using SV21T1020885.BusinessLayers;
using SV21T1020885.DomainModels;
using SV21T1020885.Web.AppCodes;
using SV21T1020885.Web.Models;
using SV21T1020885.BusinessLayers;
using SV21T1020885.DomainModels;
using SV21T1020885.Web.AppCodes;
using SV21T1020885.Web.Models;

namespace SV21T1020885.Web.Controllers
{
    public class EmployeeController : Controller
    {
        private const int PAGE_SIZE = 9;
        private const string SEARCH_CONDITION = "employee_search"; //Tên biến dùng để lưu trong session


        public IActionResult Index()
        {
            PaginationSearchInput? input = ApplicationContext.GetSessionData<PaginationSearchInput>(SEARCH_CONDITION);
            if (input == null)
            {
                input = new PaginationSearchInput()
                {
                    Page = 1,
                    PageSize = PAGE_SIZE,
                    SearchValue = ""
                };
            }
            return View(input);
        }

        public IActionResult Search(PaginationSearchInput input)
        {
            int rowCount = 0;
            var data = CommonDataService.ListOfEmployees(out rowCount, input.Page, input.PageSize, input.SearchValue ?? "");
            var model = new EmployeeSearchResult()
            {
                Page = input.Page,
                PageSize = input.PageSize,
                SearchValue = input.SearchValue ?? "",
                RowCount = rowCount,
                Data = data
            };
            ApplicationContext.SetSessionData(SEARCH_CONDITION, input);
            return View(model);
        }


        public IActionResult Create()
        {
            ViewBag.Title = "Bổ sung nhân viên";
            var model = new Employee()
            {
                EmployeeID = 0,
                BirthDate = new DateTime(1990, 1, 1),
                Photo = "nophoto.png"
            };
            return View("Edit", model);
        }

        public IActionResult Edit(int id = 0)
        {
          
            ViewBag.Title = "Cập nhật thông tin nhân viên";
            var model = CommonDataService.GetEmployee(id);
            if (model == null)
                return RedirectToAction("Index");

            if (string.IsNullOrEmpty(model.Photo))
                model.Photo = "nophoto.png";

            return View(model);
        }

        //public IActionResult Save(Employee data, string birthDateInput, IFormFile? uploadPhoto)
        //{
        //    ViewBag.Title = data.EmployeeID == 0 ? "Bổ sung nhân viên" : "Cập nhật thông tin nhân viên";

        //    //Kiểm tra dữ liệu đầu vào
        //    if (string.IsNullOrWhiteSpace(data.FullName))
        //        ModelState.AddModelError(nameof(data.FullName), "Họ tên nhân viên không được để trống");
        //    if (string.IsNullOrWhiteSpace(data.Email))
        //        ModelState.AddModelError(nameof(data.Email), "Vui lòng nhập email");
        //    if (string.IsNullOrWhiteSpace(data.Address))
        //        data.Address = "";
        //    if (string.IsNullOrWhiteSpace(data.Phone))
        //        data.Phone = "";

        //    //Xử lý ngày sinh
        //    DateTime? birthDate = birthDateInput.ToDateTime();
        //    if (birthDate.HasValue)
        //        data.BirthDate = birthDate.Value;

        //    //Xử lý với ảnh upload (nếu có ảnh upload thì lưu ảnh và gán lại tên file ảnh mới cho employee)
        //    if (uploadPhoto != null)
        //    {
        //        string fileName = $"{DateTime.Now.Ticks}_{uploadPhoto.FileName}"; //Tên file sẽ lưu
        //        string folder = Path.Combine(ApplicationContext.WebRootPath, @"assets\images\employees"); //đường dẫn đến thư mục lưu file
        //        string filePath = Path.Combine(folder, fileName); //Đường dẫn đến file cần lưu D:\images\employees\photo.png

        //        using (var stream = new FileStream(filePath, FileMode.Create))
        //        {
        //            uploadPhoto.CopyTo(stream);
        //        }
        //        data.Photo = fileName;
        //    }

        //    if (!ModelState.IsValid)
        //        return View("Edit", data);

        //    if (data.EmployeeID == 0)
        //    {
        //        CommonDataService.AddEmployee(data);
        //    }
        //    else
        //    {
        //        CommonDataService.UpdateEmployee(data);
        //    }
        //    return RedirectToAction("Index");
        //}
        public IActionResult Save(Employee data, string birthDateInput, IFormFile? uploadPhoto)
        {
            ViewBag.Title = data.EmployeeID == 0 ? "Bổ sung nhân viên" : "Cập nhật thông tin nhân viên";

            // Kiểm tra dữ liệu đầu vào
            if (string.IsNullOrWhiteSpace(data.FullName))
                ModelState.AddModelError(nameof(data.FullName), "Họ tên nhân viên không được để trống");
            if (string.IsNullOrWhiteSpace(data.Email))
                ModelState.AddModelError(nameof(data.Email), "Vui lòng nhập email");
            if (string.IsNullOrWhiteSpace(data.Address))
                data.Address = "";
            if (string.IsNullOrWhiteSpace(data.Phone))
                data.Phone = "";

            // Xử lý ngày sinh
            DateTime? birthDate = birthDateInput.ToDateTime();
            if (birthDate.HasValue)
                data.BirthDate = birthDate.Value;

            // Xử lý với ảnh upload (nếu có ảnh upload thì lưu ảnh và gán lại tên file ảnh mới cho employee)
            if (uploadPhoto != null)
            {
                var directoryPath = Path.Combine(ApplicationContext.WebRootPath, "wwwroot", "assets", "images", "employees");

                // Kiểm tra nếu thư mục chưa tồn tại thì tạo mới
                if (!Directory.Exists(directoryPath))
                {
                    Directory.CreateDirectory(directoryPath);
                }

                string fileName = $"{Guid.NewGuid()}_{Path.GetFileName(uploadPhoto.FileName)}"; // Tạo tên file mới để tránh trùng lặp
                string filePath = Path.Combine(directoryPath, fileName); // Đường dẫn đầy đủ để lưu file

                // Lưu file vào server
                using (var stream = new FileStream(filePath, FileMode.Create))
                {
                    uploadPhoto.CopyTo(stream);
                }

                // Gán tên file vào thuộc tính Photo của Employee
                data.Photo = fileName;
            }

            // Kiểm tra tính hợp lệ của Model
            if (!ModelState.IsValid)
                return View("Edit", data);

            // Thêm hoặc cập nhật thông tin nhân viên
            if (data.EmployeeID == 0)
            {
                CommonDataService.AddEmployee(data);
            }
            else
            {
                CommonDataService.UpdateEmployee(data);
            }

            // Điều hướng về trang danh sách nhân viên
            return RedirectToAction("Index");
        }



        public IActionResult Delete(int id)
        {
            if (Request.Method == "POST")
            {
                CommonDataService.DeleteEmployee(id);
                return RedirectToAction("Index");
            }

            var employee = CommonDataService.GetEmployee(id);
            if (employee == null)
            {
                return RedirectToAction("Index");
            }
            ViewBag.AllowDelete = !CommonDataService.IsUsedEmployee(id);
            return View(employee);
        }
    }
}
