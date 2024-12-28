-- # Phần A: 10 Câu Hỏi Truy Vấn (SELECT)
-- # 1. Liệt kê danh sách tài khoản (accounts) kèm tên các roles mà họ đang có.
-- # Các cột cần hiển thị: accounts.id, user_name, phone_number, status, và danh
-- # sách roles.name (nếu một account có nhiều role, hãy nhóm/gom lại).
select
    a.id as account_id,
    a.user_name,
    a.phone_number,
    a.status,
    group_concat(r.name separator ', ') as roles
from
    accounts as a
        left join
    role_accounts ra on a.id = ra.account_id
        left join
    roles as r on ra.role_id = r.id
group by
    a.id, a.user_name, a.phone_number, a.status;

-- # 2. Liệt kê danh sách orders của từng accounts, kèm địa chỉ giao hàng (shipping_address) và tên store nếu có.
-- # Các cột hiển thị: orders.id, order_note, orders.status, shipping_fee, account_id,
-- # shipping_address.full_name (người nhận hàng), stores.name (nếu đơn hàng được đặt tại store nào đó).
-- # Sắp xếp theo orders.created_at mới nhất trước.
select
    o.id as order_id,
    o.order_note,
    o.status as order_status,
    o.shipping_fee,
    o.account_id,
    sa.full_name as shipping_receiver_name,
    s.name as store_name
from
    orders o
        left join
    shipping_address sa on o.shipping_address_id = sa.id
        left join
    stores s on o.store_id = s.id
order by
    o.created_at desc;

-- # 3. Thống kê tổng giá trị đơn hàng (order_price) và tổng phí ship (shipping_fee)
-- # theo từng accounts để biết ai mua nhiều nhất.
-- # Các cột hiển thị:
-- # account_id, tổng cộng SUM(order_price) (đặt tên là TotalOrderPrice),
-- # tổng cộng SUM(shipping_fee) (đặt tên là TotalShippingFee),
-- # số đơn hàng COUNT(orders.id) (đặt tên là TotalOrders).
-- # Chỉ lấy những account nào có ít nhất 1 đơn hàng.
-- # Sắp xếp giảm dần theo TotalOrderPrice.
select
    a.id as account_id,
    sum(o.order_price) as TotalOrderPrice,
    sum(o.shipping_fee) as TotalShippingFee,
    count(o.id) as ToTalOrders
from
    accounts as a
        left join
    orders as o on a.id = o.account_id
group by a.id
having ToTalOrders > 0
order by TotalOrderPrice desc;

-- # 4. Liệt kê danh sách sản phẩm (products) kèm tên cửa hàng (store), tên danh mục (categories), và tên ngành (industry).
select
    p.id as product_id,
    p.name,
    p.price,
    p.stock_quantity,
    st.name as store_name,
    c.name as category_name,
    i.name as industry_name
from
    products as p
        join
    stores as st on p.store_id = st.id
        join
    categories as c on p.category_id = c.id
        join
    industries as i on c.industry_id = i.id;

-- # 5. Thống kê số lượng sản phẩm (products) mà mỗi store đang bán, và tổng số lượng đã bán (sold_quantity) của tất cả sản phẩm trong store đó.
-- # Các cột hiển thị:
-- # stores.id, stores.name,
-- # số lượng sản phẩm (COUNT(*)),
-- # tổng sold_quantity (SUM(sold_quantity)).
-- # Sắp xếp giảm dần theo tổng sold_quantity.
select
    s.id as store_id,
    s.name as store_name,
    count(p.id) as total_product,
    sum(p.sold_quantity) as product_sold_quantity
from
    stores as s
        join
    products as p on s.id = p.store_id
group by s.id, s.name
order by product_sold_quantity desc;

-- # 6. Liệt kê chi tiết order_items (mỗi dòng sản phẩm trong đơn hàng) kèm tên sản phẩm (products.name), giá (price trong order_items), và tên store.
-- # Các cột hiển thị:
-- # order_items.id, order_id, quantity, order_items.price (giá tại thời điểm mua),
-- # products.name,
-- # stores.name (nếu muốn biết sản phẩm thuộc store nào).
-- # JOIN qua orders -> products -> stores.
select
    oi.id as order_item_id,
    oi.order_id,
    oi.quantity,
    oi.price as purchase_price,
    p.name as product_name,
    s.name as store_name
from
    order_items oi
        join
    products p on oi.product_id = p.id
        left join
    stores s on p.store_id = s.id
order by
    oi.order_id, oi.id;

-- # 7. Liệt kê các coupon mà người dùng (accounts) sở hữu, kèm trạng thái và ngày hết hạn.
-- #
-- # Các cột hiển thị:
-- # account_coupons.account_id, coupons.code, coupons.is_active, coupons.expiry_date,
-- # Có thể thêm coupons.quantity (số lần khuyến mại).
-- # Chỉ lấy những coupon còn hiệu lực (is_active = true) và chưa hết hạn (expiry_date >= NOW(), tuỳ RDBMS).
select
    ac.account_id,
    c.code,
    c.is_active,
    c.expiry_date
from
    account_coupons as ac
        join
    coupons as c on ac.coupon_id = c.id
where
    c.is_active = true and c.expiry_date > NOW();

-- # 8. Liệt kê các reviews (đánh giá) kèm thông tin người đánh giá (accounts) và đơn hàng (orders).
-- # Các cột hiển thị:
-- # reviews.id, reviews.rating, reviews.comment,
-- # accounts.user_name (ai đánh giá),
-- # orders.id (đánh giá thuộc đơn hàng nào).
-- # Sắp xếp mới nhất trước (theo reviews.created_at DESC).
select
    r.id,
    r.rating,
    r.comment,
    a.user_name,
    r.order_id
from
    accounts as a
        join
    reviews as r on a.id = r.account_id
order by r.created_at DESC;

-- # 9. Thống kê biến thể sản phẩm (product_variants), kèm các attribute liên quan.
-- # Các cột hiển thị:
-- # product_variants.id, product_variants.product_id, product_variants.quantity,
-- # Danh sách các attributes.name (VD: màu sắc, size…) mà biến thể này sở hữu.
select
    pv.id,
    pv.product_id,
    pv.quantity,
    group_concat(at.name order by at.name) AS attributes
from
    product_variants as pv
        join
    product_variant_attributes as pva on pv.id = pva.product_variant_id
        join
    attributes as at on pva.attribute_id = at.id
group by pv.id, pv.product_id, pv.quantity;

-- # 10. Liệt kê notifications kèm tên tài khoản (accounts.user_name) đã tạo (thường là admin), chỉ lấy thông báo công khai (is_public = true).
-- # Các cột hiển thị:
-- # notifications.id, title, content, is_public, notifications.created_at,
-- # accounts.user_name.
-- # Sắp xếp notifications.created_at giảm dần.
select
    no.id,
    no.title,
    no.content,
    no.is_public,
    no.created_at,
    a.user_name as account_name
from
    notifications as no
        join
    accounts as a on no.account_id = a.id
where
    no.is_public = true
order by no.created_at DESC;

-- # Phần B: 5 Câu Hỏi Về Trigger
-- # 1. Trigger kiểm tra khi thêm mới accounts:
-- # Đề bài: Nếu status không được cung cấp, mặc định status = 1 (giả sử 1 là “active”).
-- # BEFORE INSERT trên accounts.
delimiter $$
create trigger before_insert_accounts
    before insert on accounts
    for each row
begin
    if new.status is null then
        set new.status = 1;  -- gán mặc định status = 1 nếu không có giá trị
end if;
end $$
delimiter ;

-- # 2. Trigger cấm tạo orders nếu account_id đang bị khoá (status khác “active” — tuỳ cách quản lý).
-- # Đề bài: BEFORE INSERT trên orders, kiểm tra bảng accounts.
-- # Nếu accounts.status != 1 (ví dụ 1 là active) thì báo lỗi (hoặc rollback).
delimiter $$
create trigger before_insert_orders
    before insert on orders
    for each row
begin
    declare account_status int;

    select status into account_status
    from accounts
    where id = new.account_id;

    if account_status != 1 then
        signal sqlstate '45000' set message_text = 'account is not active, cannot create order';
end if;
end $$
delimiter ;

-- # 3. Trigger khi xoá một orders, sẽ xoá luôn các order_items tương ứng (thay cho ON DELETE CASCADE).
-- # Đề bài: AFTER DELETE trên orders, xoá order_items có order_id = OLD.id.
delimiter $$
create trigger after_delete_orders
    after delete on orders
    for each row
begin
    delete from order_items
    where order_id = old.id;
end $$
delimiter ;

-- # 4. Trigger kiểm tra trước khi thêm reviews:
-- # Đề bài: Chỉ được phép thêm reviews nếu orders.status là đã hoàn thành (chẳng hạn status = 2?),
-- # BEFORE INSERT trên reviews.
-- # Kiểm tra orders.status dựa vào reviews.order_id.
delimiter $$
create trigger before_insert_reviews
    before insert on reviews
    for each row
begin
    declare order_status int;

    select status into order_status
    from orders
    where id = new.order_id;

    if order_status != 2 then
        signal sqlstate '45000' set message_text = 'Order is not completed, cannot add review';
end if;
end $$
delimiter ;

-- # 5. Trigger khi update products.sold_quantity, nếu sold_quantity vượt quá stock_quantity, báo lỗi.
-- # Đề bài: BEFORE UPDATE trên products.
-- # Kiểm tra NEW.sold_quantity <= NEW.stock_quantity.
delimiter $$
create trigger before_update_products
    before update on products
    for each row
begin
    if new.sold_quantity > new.stock_quantity then
        signal sqlstate '45000' set message_text = 'Sold quantity cannot exceed stock quantity';
end if;
end $$
delimiter ;

-- # Phần C: 5 Câu Hỏi Về Stored Procedure
-- # 1. SP thêm mới tài khoản (accounts), kèm role mặc định.
-- # Đề bài: Tham số: p_user_name, p_phone_number, p_password, v.v.
-- # Nếu role chưa được chỉ định => gán role mặc định (VD: “user”). Thêm vào role_accounts tương ứng.
-- # Tự động set created_at = NOW().
delimiter //
create procedure add_account(
    in p_user_name varchar(255),
    in p_phone_number varchar(20),
    in p_password varchar(255),
    in p_role int default 0 -- default 0 = user
)
begin
    declare v_created_at datetime;
    declare v_account_id int;

    set v_created_at = now();

insert into accounts (accounts.user_name, accounts.phone_number, accounts.password, accounts.created_at)
values (p_user_name, p_phone_number, p_password, v_created_at);

set v_account_id = last_insert_id();

insert into role_accounts (role_accounts.account_id, role_accounts.role_id)
values (v_account_id, p_role);
end //
delimiter ;

-- # 2. SP tạo đơn hàng:
-- # Đề bài: Tham số: p_account_id, p_shipping_address_id, p_order_price, p_shipping_fee, p_store_id, v.v.
-- # Tính (hoặc nhận) discount nếu có?
-- # Chèn vào bảng orders, created_at = NOW().
-- # Trả về orders.id vừa tạo (nếu DBMS hỗ trợ).
delimiter //
create procedure create_order(
    in p_account_id int,
    in p_shipping_address_id int,
    in p_order_price decimal(10, 2),
    in p_shipping_fee decimal(10, 2),
    in p_store_id int,
    in p_discount decimal(10, 2) default 0
)
begin
    declare v_total_price decimal(10, 2);
    declare v_order_id int;

    set v_total_price = p_order_price + p_shipping_fee - p_discount;

insert into orders (orders.account_id, orders.shipping_address_id, orders.order_price, orders.shipping_fee, orders.store_id, orders.discount, orders.total_price, orders.created_at)
values (p_account_id, p_shipping_address_id, p_order_price, p_shipping_fee, p_store_id, p_discount, v_total_price, now());

set v_order_id = last_insert_id();

    -- trả về id của đơn hàng
select v_order_id as order_id;
end //
delimiter ;

-- # 3. SP cập nhật trạng thái thanh toán (payments) cho 1 đơn hàng:
-- # Đề bài: Tham số: p_payment_id, p_status, …
-- # Nếu p_status = 1 (giả sử 1 là “Đã thanh toán”) => completed_at = NOW().
-- # Update bảng payments.
delimiter //
create procedure update_payment_status(
    in p_payment_id int,
    in p_status int
)
begin
    if p_status = 1 then
update payments
set status = p_status, completed_at = now()
where id = p_payment_id;
else
update payments
set status = p_status
where id = p_payment_id;
end if;
end //
delimiter ;

-- # 4. SP lấy chi tiết giỏ hàng cho 1 account_id:
-- # Đề bài: Tham số p_account_id.
-- # Trả về thông tin carts và các cart_items (JOIN sang products).
-- # Bao gồm: products.name, cart_items.quantity, products.price, …
delimiter //
create procedure get_cart_details(
    in p_account_id int
)
begin
    -- Lấy thông tin giỏ hàng và các sản phẩm trong giỏ
select
    c.id as cart_id,
    c.account_id,
    ci.id as cart_item_id,
    ci.quantity as cart_item_quantity,
    p.id as product_id,
    p.name as product_name,
    p.price as product_price
from
    carts c
        join
    cart_items ci on c.id = ci.cart_id
        join
    products p on ci.product_id = p.id
where
    c.account_id = p_account_id;
end //
delimiter ;
--
-- # 5. SP thống kê cho 1 shop (stores.id):
-- # Đề bài: Tham số p_store_id.
-- # Gồm 3 cột thông tin:
-- # Tổng số sản phẩm.
-- # Tổng số đơn hàng (trong bảng orders) liên kết với store_id.
-- # Tổng số lượng bán ra (SUM(sold_quantity)) của tất cả sản phẩm.
-- # Tuỳ ý trả về qua 3 SELECT riêng hoặc 3 biến OUT.
delimiter //
create procedure get_store_statistics(
    in p_store_id int
)
begin
    declare v_total_products int;
    declare v_total_orders int;
    declare v_total_sold_quantity int;

    -- Tổng số sản phẩm
select count(*) into v_total_products
from products
where store_id = p_store_id;

select count(distinct o.id) into v_total_orders
from orders o
where o.store_id = p_store_id;

select sum(p.sold_quantity) into v_total_sold_quantity
from products p
where p.store_id = p_store_id;

select v_total_products as total_products,
       v_total_orders as total_orders,
       v_total_sold_quantity as total_sold_quantity;
end //
delimiter ;
