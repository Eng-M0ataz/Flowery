import 'package:json_annotation/json_annotation.dart';

part 'visa_order_dto.g.dart';

@JsonSerializable()
class VisaOrderDto {
  @JsonKey(name: "message")
  final String? message;

  @JsonKey(name: "session")
  final Session? session;

  const VisaOrderDto({this.message, this.session});

  factory VisaOrderDto.fromJson(Map<String, dynamic> json) =>
      _$VisaOrderDtoFromJson(json);

  Map<String, dynamic> toJson() => _$VisaOrderDtoToJson(this);
}

@JsonSerializable()
class Session {
  @JsonKey(name: "id")
  final String? id;

  @JsonKey(name: "object")
  final String? object;

  @JsonKey(name: "adaptive_pricing")
  final AdaptivePricing? adaptivePricing;

  @JsonKey(name: "after_expiration")
  final dynamic afterExpiration;

  @JsonKey(name: "allow_promotion_codes")
  final dynamic allowPromotionCodes;

  @JsonKey(name: "amount_subtotal")
  final int? amountSubtotal;

  @JsonKey(name: "amount_total")
  final int? amountTotal;

  @JsonKey(name: "automatic_tax")
  final AutomaticTax? automaticTax;

  @JsonKey(name: "billing_address_collection")
  final dynamic billingAddressCollection;

  @JsonKey(name: "cancel_url")
  final String? cancelUrl;

  @JsonKey(name: "client_reference_id")
  final String? clientReferenceId;

  @JsonKey(name: "client_secret")
  final dynamic clientSecret;

  @JsonKey(name: "collected_information")
  final CollectedInformation? collectedInformation;

  @JsonKey(name: "consent")
  final dynamic consent;

  @JsonKey(name: "consent_collection")
  final dynamic consentCollection;

  @JsonKey(name: "created")
  final int? created;

  @JsonKey(name: "currency")
  final String? currency;

  @JsonKey(name: "currency_conversion")
  final dynamic currencyConversion;

  @JsonKey(name: "custom_fields")
  final List<dynamic>? customFields;

  @JsonKey(name: "custom_text")
  final CustomText? customText;

  @JsonKey(name: "customer")
  final dynamic customer;

  @JsonKey(name: "customer_creation")
  final String? customerCreation;

  @JsonKey(name: "customer_details")
  final CustomerDetails? customerDetails;

  @JsonKey(name: "customer_email")
  final String? customerEmail;

  @JsonKey(name: "discounts")
  final List<dynamic>? discounts;

  @JsonKey(name: "expires_at")
  final int? expiresAt;

  @JsonKey(name: "invoice")
  final dynamic invoice;

  @JsonKey(name: "invoice_creation")
  final InvoiceCreation? invoiceCreation;

  @JsonKey(name: "livemode")
  final bool? livemode;

  @JsonKey(name: "locale")
  final dynamic locale;

  @JsonKey(name: "metadata")
  final SessionMetadata? metadata;

  @JsonKey(name: "mode")
  final String? mode;

  @JsonKey(name: "origin_context")
  final dynamic originContext;

  @JsonKey(name: "payment_intent")
  final dynamic paymentIntent;

  @JsonKey(name: "payment_link")
  final dynamic paymentLink;

  @JsonKey(name: "payment_method_collection")
  final String? paymentMethodCollection;

  @JsonKey(name: "payment_method_configuration_details")
  final PaymentMethodConfigurationDetails? paymentMethodConfigurationDetails;

  @JsonKey(name: "payment_method_options")
  final PaymentMethodOptions? paymentMethodOptions;

  @JsonKey(name: "payment_method_types")
  final List<String>? paymentMethodTypes;

  @JsonKey(name: "payment_status")
  final String? paymentStatus;

  @JsonKey(name: "permissions")
  final dynamic permissions;

  @JsonKey(name: "phone_number_collection")
  final PhoneNumberCollection? phoneNumberCollection;

  @JsonKey(name: "recovered_from")
  final dynamic recoveredFrom;

  @JsonKey(name: "saved_payment_method_options")
  final dynamic savedPaymentMethodOptions;

  @JsonKey(name: "setup_intent")
  final dynamic setupIntent;

  @JsonKey(name: "shipping_address_collection")
  final dynamic shippingAddressCollection;

  @JsonKey(name: "shipping_cost")
  final dynamic shippingCost;

  @JsonKey(name: "shipping_details")
  final dynamic shippingDetails;

  @JsonKey(name: "shipping_options")
  final List<dynamic>? shippingOptions;

  @JsonKey(name: "status")
  final String? status;

  @JsonKey(name: "submit_type")
  final dynamic submitType;

  @JsonKey(name: "subscription")
  final dynamic subscription;

  @JsonKey(name: "success_url")
  final String? successUrl;

  @JsonKey(name: "total_details")
  final TotalDetails? totalDetails;

  @JsonKey(name: "ui_mode")
  final String? uiMode;

  @JsonKey(name: "url")
  final String? url;

  @JsonKey(name: "wallet_options")
  final dynamic walletOptions;

  const Session({
    this.id,
    this.object,
    this.adaptivePricing,
    this.afterExpiration,
    this.allowPromotionCodes,
    this.amountSubtotal,
    this.amountTotal,
    this.automaticTax,
    this.billingAddressCollection,
    this.cancelUrl,
    this.clientReferenceId,
    this.clientSecret,
    this.collectedInformation,
    this.consent,
    this.consentCollection,
    this.created,
    this.currency,
    this.currencyConversion,
    this.customFields,
    this.customText,
    this.customer,
    this.customerCreation,
    this.customerDetails,
    this.customerEmail,
    this.discounts,
    this.expiresAt,
    this.invoice,
    this.invoiceCreation,
    this.livemode,
    this.locale,
    this.metadata,
    this.mode,
    this.originContext,
    this.paymentIntent,
    this.paymentLink,
    this.paymentMethodCollection,
    this.paymentMethodConfigurationDetails,
    this.paymentMethodOptions,
    this.paymentMethodTypes,
    this.paymentStatus,
    this.permissions,
    this.phoneNumberCollection,
    this.recoveredFrom,
    this.savedPaymentMethodOptions,
    this.setupIntent,
    this.shippingAddressCollection,
    this.shippingCost,
    this.shippingDetails,
    this.shippingOptions,
    this.status,
    this.submitType,
    this.subscription,
    this.successUrl,
    this.totalDetails,
    this.uiMode,
    this.url,
    this.walletOptions,
  });

  factory Session.fromJson(Map<String, dynamic> json) =>
      _$SessionFromJson(json);

  Map<String, dynamic> toJson() => _$SessionToJson(this);
}

@JsonSerializable()
class AdaptivePricing {
  @JsonKey(name: "enabled")
  final bool? enabled;

  const AdaptivePricing({this.enabled});

  factory AdaptivePricing.fromJson(Map<String, dynamic> json) =>
      _$AdaptivePricingFromJson(json);

  Map<String, dynamic> toJson() => _$AdaptivePricingToJson(this);
}

@JsonSerializable()
class AutomaticTax {
  @JsonKey(name: "enabled")
  final bool? enabled;

  @JsonKey(name: "liability")
  final dynamic liability;

  @JsonKey(name: "provider")
  final dynamic provider;

  @JsonKey(name: "status")
  final dynamic status;

  const AutomaticTax({this.enabled, this.liability, this.provider, this.status});

  factory AutomaticTax.fromJson(Map<String, dynamic> json) =>
      _$AutomaticTaxFromJson(json);

  Map<String, dynamic> toJson() => _$AutomaticTaxToJson(this);
}

@JsonSerializable()
class CollectedInformation {
  @JsonKey(name: "shipping_details")
  final dynamic shippingDetails;

  const CollectedInformation({this.shippingDetails});

  factory CollectedInformation.fromJson(Map<String, dynamic> json) =>
      _$CollectedInformationFromJson(json);

  Map<String, dynamic> toJson() => _$CollectedInformationToJson(this);
}

@JsonSerializable()
class CustomText {
  @JsonKey(name: "after_submit")
  final dynamic afterSubmit;

  @JsonKey(name: "shipping_address")
  final dynamic shippingAddress;

  @JsonKey(name: "submit")
  final dynamic submit;

  @JsonKey(name: "terms_of_service_acceptance")
  final dynamic termsOfServiceAcceptance;

  const CustomText({
    this.afterSubmit,
    this.shippingAddress,
    this.submit,
    this.termsOfServiceAcceptance,
  });

  factory CustomText.fromJson(Map<String, dynamic> json) =>
      _$CustomTextFromJson(json);

  Map<String, dynamic> toJson() => _$CustomTextToJson(this);
}

@JsonSerializable()
class CustomerDetails {
  @JsonKey(name: "address")
  final dynamic address;

  @JsonKey(name: "email")
  final String? email;

  @JsonKey(name: "name")
  final dynamic name;

  @JsonKey(name: "phone")
  final dynamic phone;

  @JsonKey(name: "tax_exempt")
  final String? taxExempt;

  @JsonKey(name: "tax_ids")
  final dynamic taxIds;

  const CustomerDetails({
    this.address,
    this.email,
    this.name,
    this.phone,
    this.taxExempt,
    this.taxIds,
  });

  factory CustomerDetails.fromJson(Map<String, dynamic> json) =>
      _$CustomerDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerDetailsToJson(this);
}

@JsonSerializable()
class InvoiceCreation {
  @JsonKey(name: "enabled")
  final bool? enabled;

  @JsonKey(name: "invoice_data")
  final InvoiceData? invoiceData;

  const InvoiceCreation({this.enabled, this.invoiceData});

  factory InvoiceCreation.fromJson(Map<String, dynamic> json) =>
      _$InvoiceCreationFromJson(json);

  Map<String, dynamic> toJson() => _$InvoiceCreationToJson(this);
}

@JsonSerializable()
class InvoiceData {
  @JsonKey(name: "account_tax_ids")
  final dynamic accountTaxIds;

  @JsonKey(name: "custom_fields")
  final dynamic customFields;

  @JsonKey(name: "description")
  final dynamic description;

  @JsonKey(name: "footer")
  final dynamic footer;

  @JsonKey(name: "issuer")
  final dynamic issuer;

  @JsonKey(name: "metadata")
  final InvoiceMetadata? metadata;

  @JsonKey(name: "rendering_options")
  final dynamic renderingOptions;

  const InvoiceData({
    this.accountTaxIds,
    this.customFields,
    this.description,
    this.footer,
    this.issuer,
    this.metadata,
    this.renderingOptions,
  });

  factory InvoiceData.fromJson(Map<String, dynamic> json) =>
      _$InvoiceDataFromJson(json);

  Map<String, dynamic> toJson() => _$InvoiceDataToJson(this);
}

@JsonSerializable()
class SessionMetadata {
  @JsonKey(name: "city")
  final String? city;

  @JsonKey(name: "lat")
  final String? lat;

  @JsonKey(name: "long")
  final String? long;

  @JsonKey(name: "phone")
  final String? phone;

  @JsonKey(name: "street")
  final String? street;

  const SessionMetadata({
    this.city,
    this.lat,
    this.long,
    this.phone,
    this.street,
  });

  factory SessionMetadata.fromJson(Map<String, dynamic> json) =>
      _$SessionMetadataFromJson(json);

  Map<String, dynamic> toJson() => _$SessionMetadataToJson(this);
}

@JsonSerializable()
class InvoiceMetadata {
  const InvoiceMetadata();

  factory InvoiceMetadata.fromJson(Map<String, dynamic> json) =>
      _$InvoiceMetadataFromJson(json);

  Map<String, dynamic> toJson() => _$InvoiceMetadataToJson(this);
}

@JsonSerializable()
class PaymentMethodConfigurationDetails {
  @JsonKey(name: "id")
  final String? id;

  @JsonKey(name: "parent")
  final dynamic parent;

  const PaymentMethodConfigurationDetails({this.id, this.parent});

  factory PaymentMethodConfigurationDetails.fromJson(
      Map<String, dynamic> json) =>
      _$PaymentMethodConfigurationDetailsFromJson(json);

  Map<String, dynamic> toJson() =>
      _$PaymentMethodConfigurationDetailsToJson(this);
}

@JsonSerializable()
class PaymentMethodOptions {
  @JsonKey(name: "card")
  final Card? card;

  const PaymentMethodOptions({this.card});

  factory PaymentMethodOptions.fromJson(Map<String, dynamic> json) =>
      _$PaymentMethodOptionsFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentMethodOptionsToJson(this);
}

@JsonSerializable()
class Card {
  @JsonKey(name: "request_three_d_secure")
  final String? requestThreeDSecure;

  const Card({this.requestThreeDSecure});

  factory Card.fromJson(Map<String, dynamic> json) => _$CardFromJson(json);

  Map<String, dynamic> toJson() => _$CardToJson(this);
}

@JsonSerializable()
class PhoneNumberCollection {
  @JsonKey(name: "enabled")
  final bool? enabled;

  const PhoneNumberCollection({this.enabled});

  factory PhoneNumberCollection.fromJson(Map<String, dynamic> json) =>
      _$PhoneNumberCollectionFromJson(json);

  Map<String, dynamic> toJson() => _$PhoneNumberCollectionToJson(this);
}

@JsonSerializable()
class TotalDetails {
  @JsonKey(name: "amount_discount")
  final int? amountDiscount;

  @JsonKey(name: "amount_shipping")
  final int? amountShipping;

  @JsonKey(name: "amount_tax")
  final int? amountTax;

  const TotalDetails({this.amountDiscount, this.amountShipping, this.amountTax});

  factory TotalDetails.fromJson(Map<String, dynamic> json) =>
      _$TotalDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$TotalDetailsToJson(this);
}
