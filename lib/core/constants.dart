// Routes
const String welcomeRoute = "/welcome";
const String postcodeRoute = "/welcome/post-code";
const String firstFreeDeliveryRoute = "/welcome/first-free-delivery";
const String homeRoute = "/home";

// Secure storage keys / settings
const String firstLoggedInUser = "firstLoggedInUser";
const String appearanceSetting = "appearanceSetting";

// Table name constants
const String shopTypesTable = "shop_types";
const String shopsTable = "shops";
const String shopLabelsTable = "shop_labels";
const String productTypesTable = "product_types";
const String productsTable = "products";
const String basketsTable = "baskets";
const String basketProductsTable = "basket_products";

// Field name constants
const String colId = "id";
const String colEmail = "email";
const String colFirstName = "first_name";
const String colPostCode = "post_code";
const String colName = "name";
const String colDescription = "description";
const String colImageUrl = "image_url";
const String colPrice = "price";
const String colReducedBy = "reduced_by";
const String colStatus = "status";

// Timestamps
const String colOpensAt = "opens_at";
const String colClosesAt = "closes_at";
const String colCreatedAt = "created_at"; 
const String colUpdatedAt = "updated_at"; 
const String colDeletedAt = "deleted_at"; 
const String colExpiresAt = "expires_at";

// Foreign ids
const String colUserId = "user_id";
const String colUserTypeId = "user_type_id";
const String colShopId = "shop_id";
const String colShopTypeId = "shop_type_id";
const String colLabelIds = "label_ids";
const String colProductTypeId = "product_type_id";
const String colBasketId = "basket_id";
const String colProductId = "product_id";
const String colQuantity = "quantity";

// Enums, normally used to represent the status of a product or basket

enum BasketStatus { pending, checked_out }
enum ProductStatus { out_of_stock, running_low, in_stock }