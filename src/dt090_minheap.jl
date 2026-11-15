# ĐỀ TÀI DT090: ĐỐNG CỰC TIỂU (MIN-HEAP) ĐỂ LẤY DÃY SỐ THEO THỨ TỰ TĂNG
# Sinh viên: Đinh Việt Văn - MSSV: N24DCDT108 - Lớp: D24CQDT01-N - Nhóm 03

mutable struct Dong
    a::Vector{Int}
    Dong() = new(Int[])
end

mutable struct BoDem
    ss_them::Int
    dc_them::Int
    ss_lay::Int
    dc_lay::Int
    BoDem() = new(0, 0, 0, 0)
end

function kiem_minheap(a::Vector{Int})
    n = length(a)
    for i in 1:div(n, 2)
        trai = 2 * i
        phai = 2 * i + 1
        if trai <= n && a[i] > a[trai]
            return false
        end
        if phai <= n && a[i] > a[phai]
            return false
        end
    end
    return true
end

function them_min!(d::Dong, x::Int; dem::Union{BoDem, Nothing}=nothing)
    if length(d.a) >= 200
        throw(ArgumentError("LOI01: Dong da dat toi da 200 phan tu."))
    end
    if x < -1000 || x > 1000
        throw(ArgumentError("LOI01: Gia tri $x nam ngoai mien [-1000, 1000]."))
    end

    push!(d.a, x)
    i = length(d.a)
    while i > 1
        cha = div(i, 2)
        if dem !== nothing
            dem.ss_them += 1
        end
        if d.a[cha] > d.a[i]
            d.a[cha], d.a[i] = d.a[i], d.a[cha]
            if dem !== nothing
                dem.dc_them += 1
            end
            i = cha
        else
            break
        end
    end
    return d
end

function xem_min(d::Dong)
    isempty(d.a) && return nothing
    return d.a[1]
end

function lay_min!(d::Dong; dem::Union{BoDem, Nothing}=nothing)
    isempty(d.a) && return nothing
    goc = d.a[1]
    d.a[1] = d.a[end]
    pop!(d.a)

    i, n = 1, length(d.a)
    while true
        trai, phai, nho = 2i, 2i + 1, i
        if trai <= n
            if dem !== nothing
                dem.ss_lay += 1
            end
            if d.a[trai] < d.a[nho]
                nho = trai
            end
        end
        if phai <= n
            if dem !== nothing
                dem.ss_lay += 1
            end
            if d.a[phai] < d.a[nho]
                nho = phai
            end
        end
        nho == i && break
        d.a[i], d.a[nho] = d.a[nho], d.a[i]
        if dem !== nothing
            dem.dc_lay += 1
        end
        i = nho
    end
    return goc
end

function lay_het!(d::Dong; dem::Union{BoDem, Nothing}=nothing)
    kq = Int[]
    while !isempty(d.a)
        push!(kq, lay_min!(d; dem=dem))
    end
    return kq
end

function chay_kiem_thu()
    println("================ KET QUA KIEM THU DT090 ================")

    # --- A01: VD01 ---
    d1, dem1 = Dong(), BoDem()
    for x in [5, 2, 7, 1]
        them_min!(d1, x; dem=dem1)
    end
    truoc1 = copy(d1.a)
    lay1 = lay_min!(d1; dem=dem1)
    sau1 = copy(d1.a)
    hop_le1 = kiem_minheap(d1.a)
    pass1 = (truoc1 == [1, 2, 7, 5] && lay1 == 1 && sau1 == [2, 5, 7] && hop_le1)
    println("\n[A01 - VD01] Vi du 1 phieu: them [5, 2, 7, 1] -> lay_min!")
    println("  Expected: truoc=[1, 2, 7, 5], lay=1, sau=[2, 5, 7]")
    println("  Actual  : truoc=$truoc1, lay=$lay1, sau=$sau1, kiem_minheap=$hop_le1")
    println("  Chi phi : ss_them=$(dem1.ss_them), dc_them=$(dem1.dc_them), ss_lay=$(dem1.ss_lay), dc_lay=$(dem1.dc_lay)")
    println("  Ket luan: ", pass1 ? "PASS" : "FAIL")

    # --- A02: VD02 ---
    d2 = Dong()
    for x in [-2, 0, -2]
        them_min!(d2, x)
    end
    truoc2 = copy(d2.a)
    kq2 = lay_het!(d2)
    pass2 = (truoc2 == [-2, 0, -2] && kq2 == [-2, -2, 0] && isempty(d2.a))
    println("\n[A02 - VD02] Vi du 2 phieu: them [-2, 0, -2] -> lay_het!")
    println("  Expected: truoc=[-2, 0, -2], kq=[-2, -2, 0], sau=[]")
    println("  Actual  : truoc=$truoc2, kq=$kq2, sau=$(d2.a)")
    println("  Ket luan: ", pass2 ? "PASS" : "FAIL")

    # --- A03: TK01 ---
    d3 = Dong()
    for x in [10, 8, 6, 4, 2]
        them_min!(d3, x)
    end
    pass3 = (d3.a == [2, 4, 8, 10, 6] && xem_min(d3) == 2 && kiem_minheap(d3.a))
    println("\n[A03 - TK01] Day giam dan [10, 8, 6, 4, 2]")
    println("  Actual  : d.a=$(d3.a), xem_min=$(xem_min(d3)), kiem_minheap=$(kiem_minheap(d3.a))")
    println("  Ket luan: ", pass3 ? "PASS" : "FAIL")

    # --- A04: TK02 ---
    d4 = Dong()
    for x in [9, -4, 7, 1, -5, 3]
        them_min!(d4, x)
    end
    truoc4 = copy(d4.a)
    kq4 = lay_het!(d4)
    pass4 = (truoc4 == [-5, -4, 3, 9, 1, 7] && kq4 == [-5, -4, 1, 3, 7, 9] && isempty(d4.a))
    println("\n[A04 - TK02] Day am duong lon xon [9, -4, 7, 1, -5, 3]")
    println("  Actual  : truoc=$truoc4, kq=$kq4, sau=$(d4.a)")
    println("  Ket luan: ", pass4 ? "PASS" : "FAIL")

    # --- A05: BIEN01 ---
    d5 = Dong()
    r1, r2 = xem_min(d5), lay_min!(d5)
    them_min!(d5, 42)
    m1, m2 = xem_min(d5), lay_min!(d5)
    pass5 = (r1 === nothing && r2 === nothing && m1 == 42 && m2 == 42 && isempty(d5.a))
    println("\n[A05 - BIEN01] Dong rong va dong 1 phan tu [42]")
    println("  Actual  : rong=($r1, $r2), mot_pt=($m1, $m2), sau=$(d5.a)")
    println("  Ket luan: ", pass5 ? "PASS" : "FAIL")

    # --- A06: BIEN02 ---
    d6 = Dong()
    for x in [1, 3, 3, 5]
        them_min!(d6, x)
    end
    lay6 = lay_min!(d6)
    pass6 = (lay6 == 1 && d6.a == [3, 5, 3] && kiem_minheap(d6.a))
    println("\n[A06 - BIEN02] Quy tac hoa hai con bang nhau (uu tien con trai)")
    println("  Actual  : lay=$lay6, sau=$(d6.a), kiem_minheap=$(kiem_minheap(d6.a))")
    println("  Ket luan: ", pass6 ? "PASS" : "FAIL")

    # --- A07: BIEN03 ---
    d7 = Dong()
    them_min!(d7, -1000)
    them_min!(d7, 1000)
    for _ in 1:198
        them_min!(d7, 0)
    end
    pass7 = (length(d7.a) == 200 && xem_min(d7) == -1000 && kiem_minheap(d7.a))
    println("\n[A07 - BIEN03] Bien gia tri [-1000, 1000] va kich thuoc toi da n=200")
    println("  Actual  : length=$(length(d7.a)), xem_min=$(xem_min(d7)), kiem_minheap=$(kiem_minheap(d7.a))")
    println("  Ket luan: ", pass7 ? "PASS" : "FAIL")

    # --- A08: LOI01 ---
    d8 = Dong()
    err_mien = ""
    try
        them_min!(d8, 1001)
    catch e
        err_mien = sprint(showerror, e)
    end
    err_tran = ""
    try
        them_min!(d7, 5) # d7 da du 200 phan tu
    catch e
        err_tran = sprint(showerror, e)
    end
    pass8 = (startswith(err_mien, "ArgumentError: LOI01") && startswith(err_tran, "ArgumentError: LOI01") && isempty(d8.a) && length(d7.a) == 200)
    println("\n[A08 - LOI01] Kiem tra input sai (vuot mien va vuot 200 phan tu)")
    println("  Actual  : loi_mien=\"$err_mien\"")
    println("            loi_tran=\"$err_tran\"")
    println("  Ket luan: ", pass8 ? "PASS" : "FAIL")

    # --- KT09 -> KT12 ---
    d9, dem9 = Dong(), BoDem()
    for x in [1, 3, 5, 7, 9]; them_min!(d9, x; dem=dem9); end
    println("\n[KT09] Truong hop tot nhat [1, 3, 5, 7, 9]: ss_them=$(dem9.ss_them), dc_them=$(dem9.dc_them) -> ", (dem9.ss_them == 4 && dem9.dc_them == 0) ? "PASS" : "FAIL")

    d10, dem10 = Dong(), BoDem()
    for x in [5, 5, 5, 5]; them_min!(d10, x; dem=dem10); end
    kq10 = lay_het!(d10; dem=dem10)
    println("[KT10] Phan tu dong nhat [5, 5, 5, 5]: kq=$kq10, ss_them=$(dem10.ss_them), dc_them=$(dem10.dc_them), ss_lay=$(dem10.ss_lay), dc_lay=$(dem10.dc_lay) -> ", (kq10 == [5, 5, 5, 5] && dem10.dc_them == 0 && dem10.dc_lay == 0) ? "PASS" : "FAIL")

    v1, v2, v3 = kiem_minheap([1, 2, 7, 5]), kiem_minheap([2, 1, 7, 5]), kiem_minheap([1, 5, 0, 8])
    println("[KT11] Validator kiem_minheap: ($v1, $v2, $v3) -> ", (v1 && !v2 && !v3) ? "PASS" : "FAIL")

    d12 = Dong()
    them_min!(d12, 8); them_min!(d12, 3); c1 = lay_min!(d12)
    them_min!(d12, 1); them_min!(d12, 6); c2 = xem_min(d12); c3 = lay_min!(d12)
    println("[KT12] Thao tac xen ke: kq=($c1, $c2, $c3), sau=$(d12.a), hop_le=$(kiem_minheap(d12.a)) -> ", ((c1, c2, c3) == (3, 1, 1) && d12.a == [6, 8] && kiem_minheap(d12.a)) ? "PASS" : "FAIL")

# --- A09: TONG KET TOAN BO KIEM THU ---
    ds_ket_qua = [pass1, pass2, pass3, pass4, pass5, pass6, pass7, pass8,
                  (dem9.ss_them == 4 && dem9.dc_them == 0),
                  (kq10 == [5, 5, 5, 5] && dem10.dc_them == 0 && dem10.dc_lay == 0),
                  (v1 && !v2 && !v3),
                  ((c1, c2, c3) == (3, 1, 1) && d12.a == [6, 8] && kiem_minheap(d12.a))]
    so_pass = count(identity, ds_ket_qua)
    so_fail = length(ds_ket_qua) - so_pass
    @assert so_fail == 0 "Co ca kiem thu bi that bai!"
    println("\n[A09 - TONG KET] Chay doc lap toan bo 12 ca kiem thu DT090")
    println("  Tong so ca: $(length(ds_ket_qua)) | PASS: $so_pass | FAIL: $so_fail | So dieu kien kiem tra (assert): 39")
    println("  Ket luan chung: DAT TOAN BO BO KIEM THU")
end

function chay_mot_luot_do(du_lieu::Vector{Int})
    d = Dong()
    for x in du_lieu
        them_min!(d, x)
    end
    return lay_het!(d)
end

function khao_sat_quy_mo()
    println("\n================ KHAO SAT BA QUY MO Q1, Q2, Q3 ================")
    # Lam nong JIT compiler truoc khi do
    chay_mot_luot_do([5, 2, 7, 1])

    for (nhan, n) in [("Q1", 20), ("Q2", 80), ("Q3", 200)]
        du_lieu = [mod(k * 757 + 131, 2001) - 1000 for k in 1:n]
        d, dem = Dong(), BoDem()
        for x in du_lieu
            them_min!(d, x; dem=dem)
        end
        lay_het!(d; dem=dem)

        bo_nho_bytes = @allocated chay_mot_luot_do(du_lieu)
        ds_thoi_gian_us = Float64[]
        for _ in 1:1000
            t0 = time_ns()
            chay_mot_luot_do(du_lieu)
            t1 = time_ns()
            push!(ds_thoi_gian_us, (t1 - t0) / 1000.0)
        end
        sort!(ds_thoi_gian_us)
        trung_vi_us = ds_thoi_gian_us[500]

        tong_ss = dem.ss_them + dem.ss_lay
        tong_dc = dem.dc_them + dem.dc_lay
        println("[$nhan | n = $n]")
        println("  Phep dem : ss_them=$(dem.ss_them), dc_them=$(dem.dc_them) | ss_lay=$(dem.ss_lay), dc_lay=$(dem.dc_lay)")
        println("  Tong hop : tong_so_sanh=$tong_ss, tong_doi_cho=$tong_dc, tong_thao_tac=$(tong_ss + tong_dc)")
        println("  Tai nguyen: trung_vi_thoi_gian=$(round(trung_vi_us, digits=2)) us (1000 lan), bo_nho_cap_phat=$bo_nho_bytes bytes")
    end
end

chay_kiem_thu()
khao_sat_quy_mo()