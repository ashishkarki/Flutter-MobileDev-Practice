enum ResponseButtonType {
  TRUE,
  FALSE,
}

String responseButtonStringUtil(ResponseButtonType buttonType) {
  String response = '';
  switch (buttonType) {
    case ResponseButtonType.TRUE:
      response = 'True';
      break;
    case ResponseButtonType.FALSE:
      response = 'False';
      break;
    default:
      response = 'False';
      break;
  }

  return response;
}
