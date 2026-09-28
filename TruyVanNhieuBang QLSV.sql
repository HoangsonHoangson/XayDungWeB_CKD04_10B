use QLSV2

select * from SV where QueQuan in (N'Hà Giang', N'Bắc Ninh')
--1 Hiển thị các lớp có trong cơ sở dữ liệu sinh viên
select distinct lop from SV
--2 Đếm số lượng sinh viên theo giới tính là nữ
select count(MaSV) from SV where GioiTinh=N'Nữ'
--3 Hiển thị điểm cao nhất trong bảng kết quả
select Max(Diem) From KQ
--4 Sắp xếp theo thứ tự tăng dần trong bảng kết quả với cột điểm
select * from KQ order by Diem asc
--5 Tính điểm trung bình các môn đã thi của sinh viên có mã số là 2, hiển thị điểm với 2 số thập phân. Ví dụ 7.50
select round(avg(Diem), 2) from KQ where MaSV=2
select * from KQ
--6 Lớp có nhiều sinh viên nhất
select top 1 Lop, count(MaSV) from SV group by Lop order by Lop asc
-- 7 Đếm số môn học mà sinh viên 1 đã thi
select count(MaMH) from KQ where Masv=1
--8 Hiển thị Mã SV, Tên SV, Môn học, Điểm
select a.MaSV, TenSV, TenMH, Diem
from SV a, MH b, KQ c
where a.MaSV=c.MaSV and b.MaMH=c.MaMH
--9 Hiển thị tên môn học mà mã sinh viên 1 đã thi 
Select Mh.TenMH from KQ, MH where Mh.MaMH=Kq.MaMH and MaSV=1
--10 Hiển thị mã sinh viên, tên môn học và điểm của sinh viên có mã sv là 2
SELECT SV.MaSV, MH.TenMH, KQ.Diem
FROM SV
JOIN  KQ ON SV.MaSV = KQ.MaSV
JOIN  MH ON KQ.MaMH = MH.MaMH
WHERE SV.MaSV = 2;
-- 11 Đếm số môn của mỗi sinh viên đã thi
SELECT SV.MaSV, SV.TenSV, COUNT(KQ.MaMH) AS SoMonDaThi
FROM  SV
JOIN KQ ON SV.MaSV = KQ.MaSV
GROUP BY SV.MaSV, SV.TenSV;
--12 Hiển thị Điểm cao nhất của mỗi môn học
SELECT MH.MaMH, MH.TenMH, MAX(KQ.Diem) AS DiemCaoNhat
FROM  MH
JOIN  KQ ON MH.MaMH = KQ.MaMH
GROUP BY MH.MaMH, MH.TenMH;
--13 Hiển thị Tên SV, Tên Môn học và điểm của Sinh viên
SELECT SV.TenSV, MH.TenMH, KQ.Diem
FROM  SV
JOIN  KQ ON SV.MaSV = KQ.MaSV
JOIN  MH ON KQ.MaMH = MH.MaMH;
--14 Hiển thị mã sinh viên , mã môn học, tên môn học của sinh viên có mã từ 2-4 và sắp xếp kết quả theo giảm dần của mã sinh viên
SELECT SV.MaSV, MH.MaMH, MH.TenMH
FROM  SV
JOIN  KQ ON SV.MaSV = KQ.MaSV
JOIN  MH ON KQ.MaMH = MH.MaMH
WHERE SV.MaSV BETWEEN 2 AND 4
ORDER BY SV.MaSV DESC;
-- 15 hiển thị Tên SV, quê của sinh viên có điểm > 8
SELECT DISTINCT SV.TenSV, SV.QueQuan, Diem
FROM  SV
JOIN  KQ ON SV.MaSV = KQ.MaSV
WHERE KQ.Diem > 8;
--16 Hiển thị Tên SV và điểm của sinh viên đã thi môn Tin học
SELECT SV.TenSV, KQ.Diem
FROM  SV
JOIN  KQ ON SV.MaSV = KQ.MaSV
JOIN  MH ON KQ.MaMH = MH.MaMH
WHERE MH.TenMH = N'Tin học';
--17 Hiển thị tên sinh viên, tên môn học và điểm < 5
SELECT SV.TenSV, MH.TenMH, KQ.Diem
FROM  SV
JOIN  KQ ON SV.MaSV = KQ.MaSV
JOIN  MH ON KQ.MaMH = MH.MaMH
WHERE KQ.Diem < 5;
--18 Hiển thị Tên sinh viên có điểm trung bình > 7
SELECT SV.TenSV, AVG(KQ.Diem) AS DiemTrungBinh
FROM  SV
JOIN  KQ ON SV.MaSV = KQ.MaSV
GROUP BY SV.MaSV, SV.TenSV
HAVING AVG(KQ.Diem) > 7;
--19 Hiển thị Mã môn học và tên môn học có ít nhất 2 sinh viên học
SELECT MH.MaMH, MH.TenMH, COUNT(DISTINCT KQ.MaSV) AS SoSinhVien
FROM  MH
JOIN  KQ ON MH.MaMH = KQ.MaMH
GROUP BY MH.MaMH, MH.TenMH
HAVING COUNT(DISTINCT KQ.MaSV) >= 1;
--20 Tổng số tín chỉ mà mỗi sinh viên đã có kết quả thi
SELECT SV.MaSV, SV.TenSV, SUM(MH.DVHT) AS TongSoTinChi
FROM  SV
JOIN  KQ ON SV.MaSV = KQ.MaSV
JOIN  MH ON KQ.MaMH = MH.MaMH
GROUP BY SV.MaSV, SV.TenSV;
