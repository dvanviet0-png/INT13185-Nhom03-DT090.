# Đề tài DT090: Đống cực tiểu (Min-heap) để lấy dãy số theo thứ tự tăng

- **Môn học:** Thực hành Cấu trúc dữ liệu và Giải thuật (INT13185) — Nhóm 03
- **Giảng viên hướng dẫn:** Hồ Nhựt Minh
- **Sinh viên thực hiện:** Đinh Việt Văn — MSSV: N24DCDT108 — Lớp: D24CQDT01-N
- **Môi trường thực thi:** Julia 1.12.7 (chỉ sử dụng thư viện chuẩn)

## Cấu trúc thư mục dự án
- `src/dt090_minheap.jl`: Mã nguồn cài đặt cấu trúc đống cực tiểu (`Dong`), bộ đếm thao tác (`BoDem`), 12 ca kiểm thử độc lập và khảo sát 3 quy mô `Q1`, `Q2`, `Q3`.
- `minh_chung/`: Thư mục lưu trữ toàn bộ ảnh chụp màn hình bằng chứng kiểm thử (`A01` đến `A11`).

## Lệnh chạy kiểm thử và khảo sát quy mô
```bash
julia --project=. src/dt090_minheap.jl