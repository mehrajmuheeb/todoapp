import 'package:base_flutter/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InputField extends StatefulWidget {
  InputField(
      {Key? key,
      required this.onTextChange,
      required this.labelText,
      this.isPassword = false,
      this.isEmail = false,
      this.isPhone = false,
      this.inputText = "",
      this.isEnabled = true,
      this.maxLength = 30,
      this.size = 20,
      required this.validator,
      this.isNumber = false,
      this.animated = true,
      this.fillColor = Colors.grey,
      this.filled = false,
      this.prefixIcon,
      this.leadingIcon})
      : super(key: key);

  final Function onTextChange;
  final String labelText;
  bool isPassword;
  bool isEmail;
  bool isPhone;
  bool isEnabled;
  String? inputText;
  int maxLength;
  double size;
  String? Function(String?)? validator;
  bool isNumber = false;
  bool animated = true;
  Color fillColor;
  bool filled = false;
  Widget? prefixIcon;
  Widget? leadingIcon;

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool isPassword = false;
  bool isEmail = false;
  bool isPhone = false;
  bool isEnabled = true;
  bool isNumber = false;
  bool animated = true;
  double size = 20;
  Color fillColor = Colors.black;
  bool filled = false;
  Widget? prefixIcon;
  Widget? leadingIcon;

  String? Function(String?)? validator;
  TextEditingController? controller;

  @override
  void initState() {
    isPassword = widget.isPassword;
    isEmail = widget.isEmail;
    isPhone = widget.isPhone;
    validator = widget.validator;
    size = widget.size;
    controller = TextEditingController();
    isNumber = widget.isNumber;
    animated = widget.animated;
    fillColor = widget.fillColor;
    filled = widget.filled;
    prefixIcon = widget.prefixIcon;
    leadingIcon = widget.leadingIcon;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.inputText != null && widget.inputText!.isNotEmpty) {
      controller?.text = widget.inputText ?? "";
      controller?.selection = TextSelection.collapsed(offset: controller?.text.length ?? 0);
      isEnabled = widget.isEnabled;
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        //key: key,
        obscuringCharacter: "*",
        controller: controller,
        enabled: isEnabled,
        obscureText: isPassword,
        maxLength: widget.maxLength,
        keyboardType: isNumber ? TextInputType.number : null,
        inputFormatters: [
          isNumber
              ? FilteringTextInputFormatter.digitsOnly
              : FilteringTextInputFormatter.singleLineFormatter
        ],
        maxLengthEnforcement: MaxLengthEnforcement.enforced,
        style: TextStyle(
            fontFamily: "Poppins_Regular",
            fontWeight: FontWeight.w400,
            color: Colors.black,
            fontSize: size),
        validator: validator,
        onChanged: (value) => widget.onTextChange(value),
        decoration: InputDecoration(
            prefixIcon: isPhone ? const NumberFieldPrefix() : prefixIcon,
            errorMaxLines: 4,
            suffixIcon: (widget.isPassword)
                ? IconButton(
                    icon: isPassword
                        ? const Image(image: AssetImage("assets/images/ic_password_hide.png"))
                        : const Icon(Icons.remove_red_eye_rounded, color: colorCE,),
                    onPressed: () {
                      setState(() {
                        isPassword = !isPassword;
                      });
                    },
                  )
                : leadingIcon,
            counterText: "",
            floatingLabelBehavior: animated
                ? FloatingLabelBehavior.auto
                : FloatingLabelBehavior.never,
            label: Text(widget.labelText, style: const TextStyle(
              fontFamily: "Messina_Reg",
              fontSize: 18,
              color: color63
            ),),
            filled: filled,
            fillColor: fillColor,
            focusedErrorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(32)),
                borderSide: BorderSide(color: colorCE)),
            errorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(32)),
                borderSide: BorderSide(color: Colors.red)),
            focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(32)),
                borderSide: BorderSide(color: colorCE)),
            enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(32)),
                borderSide: BorderSide(color: colorCE)),
            disabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(32)),
                borderSide: BorderSide(color: colorCE))),
      ),
    );
  }
}

class NumberFieldPrefix extends StatelessWidget {
  const NumberFieldPrefix({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          SizedBox(width: 4,),
          Image(
            image: AssetImage("assets/images/ic_flag.png"),
            fit: BoxFit.none,
          ),
          SizedBox(
            width: 8,
          ),
          Text(
            "+1",
            style: TextStyle(color: Colors.black, fontSize: 14),
          ),
          Icon(Icons.arrow_drop_down, color: Colors.black,)
        ],
      ),
    );
  }
}
