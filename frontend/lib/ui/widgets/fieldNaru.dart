part of 'widgets.dart';

class TextFieldNaru extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final bool isPassword;
  final TextInputType keyboardType;
  final FormFieldValidator<String>? validator;
  final String? errorText;
  final double fontSzie;

  const TextFieldNaru({
    Key? key,
    required this.controller,
    this.hintText,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.errorText,
    this.fontSzie = 18,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: TextStyle(
        fontFamily: 'NanumSquareRound',
        fontSize: fontSzie,
      ),
      // style: GoogleFonts.getFont('Roboto', fontSize: 18),
      cursorColor: ThemeColors.secondary,
      obscureText: isPassword,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: ThemeColors.primary),
        ),
        hintText: hintText,
        errorText: errorText,
      ),
      validator: validator,
    );
  }
}
