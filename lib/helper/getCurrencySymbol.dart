String getCurrencySymbol(String currency) {
  switch (currency) {
    case "USD":
      return "\$";
    case "EGP":
      return "EGP";
    case "EUR":
      return "€";
    case "GBP":
      return "£";
    case "SAR":
      return "SAR";
    case "AED":
      return "AED";
    case "KWD":
      return "KWD";
    default:
      return "\$";
  }
}
