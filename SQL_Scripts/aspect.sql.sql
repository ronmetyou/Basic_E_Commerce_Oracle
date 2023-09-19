-----------------------------------------------------------------

create or replace PROCEDURE ADD_CUSTOMER(
cust_id_arg IN DECIMAL,
first_name_arg IN VARCHAR,
last_name_arg IN VARCHAR,
cust_total_arg IN DECIMAL)
IS
BEGIN
INSERT INTO CUSTOMER
(customer_id,customer_first,customer_last,customer_total)
VALUES(cust_id_arg,first_name_arg,last_name_arg,cust_total_arg);
END;


SELECT LAST_NAME,COUNT(*) FROM
SHOPPER
GROUP BY LAST_NAME
HAVING (*)>0;

---------------------------------------------------------------
create or replace PROCEDURE UPDATE_PRODUCT_VENDOR_INVENTORY(
Product_ID_arg IN DECIMAL,
Vendor_ID_arg IN DECIMAL,
Product_Price_arg IN DECIMAL,
Product_Quantity_arg IN DECIMAL)
AS PROD_COUNT NUMBER;

 BEGIN
 SELECT COUNT(*)
 INTO PROD_COUNT
 FROM PRODUCT_VENDOR WHERE Product_ID=Product_ID_arg AND Vendor_ID=Vendor_ID_arg;
 UPDATE PRODUCT_VENDOR
 SET Product_Quantity=(PROD_COUNT+Product_Quantity_arg),Product_Price=Product_price_arg
 WHERE Product_ID=Product_ID_arg AND Vendor_ID=Vendor_ID_arg;
 END;

SELECT * FROM Product_Details, Product_Vendor WHERE Products_Details.ID=Product_Vendor.Product_ID AND Product_Quantity<=1;

-----------------------------------------------------------------

create or replace PROCEDURE ADD_NEW_PRODUCT_DETAILS(
Product_ID_arg IN DECIMAL,
Name_arg IN VARCHAR,
DESCRIPTION_arg IN VARCHAR,
CATEGORY_arg IN VARCHAR,
CONTENTS_arg IN VARCHAR,
VENDOR_ID_arg IN VARCHAR,
PRODUCT_PRICE_arg IN DECIMAL,
PRODUCT_QUANTITY_arg IN DECIMAL)
IS
BEGIN
INSERT INTO PRODUCT_DETAILS
(ID,NAME,DESCRIPTION,CATEGORY,CONTENTS)
VALUES(Product_ID_arg,Name_arg,DESCRIPTION_arg,CATEGORY_arg,CONTENTS_arg);
INSERT INTO PRODUCT_VENDOR
(Product_ID,VENDOR_ID,PRODUCT_PRICE,PRODUCT_QUANTITY)
VALUES(Product_ID_arg,VENDOR_ID_arg,PRODUCT_PRICE_arg,PRODUCT_QUANTITY_arg);
END;


SELECT * Product_Details.ID,Product_Details.Name,Product_Details.Name,Product_Details.Category,Product_Vendor.Product_Price
From Product_Details, Product_Vendor
WHERE Product_Details.ID=Product_Vendor.Product_ID AND Product_Details.Category IN ('SUV') AND Product_Vendor.Product_Price<125000;


-----------------------------------------------------------------

create or replace PROCEDURE ADD_NEW_PRODUCT_VENDOR(
Product_ID_arg IN DECIMAL,
name_arg IN VARCHAR,
DESCRIPTION_arg IN VARCHAR,
CATEGORY_arg IN VARCHAR,
CONTENTS_arg IN VARCHAR,
Vendor_ID_arg IN DECIMAL,
Product_Price_arg IN DECIMAL,
Product_Quantity_arg IN VARCHAR)
AS PROD_COUNT NUMBER;

BEGIN
    BEGIN   SELECT COUNT(*)
        INTO PROD_COUNT
        FROM PRODUCT_DETAILS
        WHERE ID=Product_ID_arg;
    EXCEPTION
        WHEN OTHERS THEN
        dbms_output.put_line('ERROR');
    END;

    IF PROD_COUNT=0 THEN
        ADD_NEW_PRODUCT_DETAILS(Product_ID_arg,Name_arg,DESCRIPTION_arg,CATEGORY_arg,CONTENTS_arg,VENDOR_ID_arg,PRODUCT_PRICE_arg,PRODUCT_QUANTITY_arg);
    ELSE
        INSERT INTO PRODUCT_VENDOR(Product_ID,Vendor_ID,Product_Price,Product_Quantity)
        VALUES(Product_ID_arg,Vendor_ID_arg,Product_Price_arg,Product_Quantity_arg);
    END IF;
END ADD_NEW_PRODUCT_VENDOR;


SELECT * FROM ORDERS


-----------------------------------------------------------------

create or replace PROCEDURE SHIP_ORDER (
Tracking_ID_arg IN NVARCHAR2,
Order_ID_arg IN NVARCHAR2,
Status_arg IN VARCHAR,
Shipping_Address_arg IN Varchar
)
AS ORDER_SHIPPING_ADDRESS varchar(255);
BEGIN
SELECT SHIPPING_ADDRESS INTO ORDER_SHIPPING_ADDRESS
FROM SHOPPER,ORDERS
WHERE SHOPPER.ID=ORDERS.SHOPPER_ID AND ORDERS.ID=Order_ID_arg;
INSERT INTO TRACKING(Tracking_ID,Order_ID,Status,Shipping_Address)
VALUES (Tracking_ID_arg,Order_ID_arg,Status_arg,Shipping_Address_arg);
END;  


SELECT COUNT(*) FROM TRACKING WHERE STATUS = 'SHIPPED';

-----------------------------------------------------------------

