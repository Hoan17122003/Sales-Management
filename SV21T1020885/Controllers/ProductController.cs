﻿using Microsoft.AspNetCore.Mvc;
using SV21T1020885.BusinessLayers;
using SV21T1020885.DomainModels;
using SV21T1020885.Web.AppCodes;

namespace SV21T1020885.Web.Controllers
{
    public class ProductController : Controller
    {
        const int PAGE_SIZE = 20;
        public IActionResult Index(int page = 1, string searchValue = "", int categoryId = 0, int supplierId = 0, decimal minPrice = 0, decimal maxPrice = 0)
        {
            int rowCount = 0;
            var data = ProductDataService.ListProducts(out rowCount, page, PAGE_SIZE, searchValue ?? "", categoryId, supplierId, minPrice, maxPrice);

            Models.ProductSearchResult model = new Models.ProductSearchResult()
            {
                Page = page,
                PageSize = PAGE_SIZE,
                RowCount = rowCount,
                SearchValue = searchValue ?? "",
                CategoryId = categoryId,
                SupplierId = supplierId,
                MinPrice = minPrice,
                MaxPrice = maxPrice,
                Data = data
            };

            return View(model);
        }

        public IActionResult Create()
        {
            ViewBag.Title = "Bổ sung sản phẩm";

            Product product = new Product()
            {
                ProductID = 0
            };

            return View("Edit", product);
        }
        public IActionResult Edit(int id = 0)
        {
            ViewBag.Title = "Cập nhật thông tin sản phẩm";

            Product? product = ProductDataService.GetProduct(id);
            if (product == null)
                return RedirectToAction("Index");

            return View(product);
        }

        [HttpPost]
        public IActionResult Save(Product? data, IFormFile? uploadFile)
        {
            //return Json(data);  
            ViewBag.Title = data.ProductID == 0 ? "Bổ sung sản phẩm" : "Cập nhật thông tin sản phẩm";

            if (string.IsNullOrWhiteSpace(data.ProductName))
            {
                ModelState.AddModelError(nameof(data.ProductName), "Tên sản phẩm không được để trống");
            }
            if (string.IsNullOrWhiteSpace(data.Unit))
            {
                ModelState.AddModelError(nameof(data.Unit), "Đơn vị tính không được để trống");
            }
            if (data.Price <= 0)
            {
                ModelState.AddModelError(nameof(data.Price), "Giá tiền không hợp lệ");
            }
            if (data.CategoryID <= 0)
            {
                ModelState.AddModelError(nameof(data.CategoryID), "Vui lòng chọn mã loại hàng");
            }
            if (data.SupplierID <= 0)
            {
                ModelState.AddModelError(nameof(data.SupplierID), "Vui lòng chọn nhà cung cấp");
            }

            data.ProductDescription = data.ProductDescription ?? "";
            data.IsSelling = data.IsSelling;
            var photo = data.Photo;
            if (uploadFile != null)
            {
                string fileName = $"{DateTime.Now.Ticks}_{uploadFile.FileName}"; //Tên file sẽ lưu
                string folder = Path.Combine(ApplicationContext.WebRootPath, @"assets\images"); //đường dẫn đến thư mục lưu file
                string filePath = Path.Combine(folder, fileName); //Đường dẫn đến file cần lưu D:\images\employees\photo.png

                using (var stream = new FileStream(filePath, FileMode.Create))
                {
                    uploadFile.CopyTo(stream);
                }
                photo = fileName;
            }
            data.Photo = photo;

            if (!ModelState.IsValid)
            {
                return View("Edit", data);
            }

            if (data.ProductID == 0)
            {
                ProductDataService.AddProduct(data);
            }
            else
            {
                ProductDataService.UpdateProduct(data);
            }
            return RedirectToAction("Index");
        }

        public IActionResult Delete(int id = 0)
        {
            if (Request.Method == "POST")
            {
                ProductDataService.DeleteProduct(id);
                return RedirectToAction("Index");
            }

            var product = ProductDataService.GetProduct(id);
            if (product == null)
            {
                return RedirectToAction("Index");
            }
            ViewBag.AllowDelete = !ProductDataService.IsUsedProduct(id);
            return View(product);
        }

        public IActionResult Photo(int id = 0, string method = "", int photoId = 0)
        {
            switch (method)
            {
                case "add":
                    ViewBag.Title = "Bổ sung ảnh cho mặt hàng";
                    ProductPhoto photo = new ProductPhoto()
                    {
                        ProductID = id,
                        PhotoID = photoId
                    };
                    return View(photo);

                case "edit":
                    ViewBag.Title = "Thay đổi ảnh của mặt hàng";
                    ProductPhoto? photo2 = ProductDataService.GetPhoto(photoId);
                    if (photo2 == null)
                        return RedirectToAction("Edit");
                    return View(photo2);

                case "delete":
                    //Xóa ảnh trực tiếp, Không cần confirm
                    ProductDataService.DeletePhoto(photoId);
                    return RedirectToAction("Edit", new { id = id });
                default:
                    return RedirectToAction("Index");
            }
        }

        public IActionResult PhotoSave(ProductPhoto? data, IFormFile? uploadPhoto)
        {
            var photo = data.Photo;
            if (uploadPhoto != null)
            {
                string fileName = $"{DateTime.Now.Ticks}_{uploadPhoto.FileName}"; //Tên file sẽ lưu
                string folder = Path.Combine(ApplicationContext.WebRootPath, @"assets\images\products"); //đường dẫn đến thư mục lưu file
                string filePath = Path.Combine(folder, fileName); 

                using (var stream = new FileStream(filePath, FileMode.Create))
                {
                    uploadPhoto.CopyTo(stream);
                }
                photo = fileName;
            }
            data.Photo = photo;

            if (data.PhotoID == 0)
            {
                ProductDataService.AddPhoto(data);
            }
            else
            {
                ProductDataService.UpdatePhoto(data);
            }
            return RedirectToAction("Edit", new { id = data.ProductID });
        }

        public IActionResult Attribute(int id = 0, string method = "", int attributeId = 0)
        {
            var data = ProductDataService.ListAttributes(id);
            switch (method)
            {
                case "add":
                    ViewBag.Title = "Bổ sung thuộc tính cho mặt hàng";
                    ProductAttribute attr = new ProductAttribute()
                    {
                        ProductID = id,
                        AttributeID = attributeId
                    };
                    return View(attr);
                case "edit":
                    ViewBag.Title = "Thay đổi thuộc tính của mặt hàng";
                    ProductAttribute? attr2 = ProductDataService.GetAttribute(attributeId);
                    if (attr2 == null)
                        return RedirectToAction("Edit");
                    return View(data);
                case "delete":
                    //Xóa ảnh trực tiếp, Không cần confirm
                    ProductDataService.DeleteAttribute(attributeId);
                    return RedirectToAction("Edit", new { id = id });
                default:
                    return RedirectToAction("Index");
            }
        }
        public IActionResult AttributeSave(ProductAttribute? data)
        {
            if (data.AttributeID == 0)
            {
                ProductDataService.AddAttribute(data);
            }
            else
            {
                ProductDataService.UpdateAttribute(data);
            }
            return RedirectToAction("Edit", new { id = data.ProductID });
        }
    }
}
