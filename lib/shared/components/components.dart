import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

Widget defaultFormField(
    {@required TextEditingController controller,
      @required TextInputType type,
      Function onSubmit,
      Function onChange,
      Function onTap,
      Function onsave,
      bool isPassword = false,
      @required Function validate,
      @required String label,
      @required IconData prefix,
      IconData suffix,
      Function suffixPressed,
      bool isClickable = true,
      String hint,
      BuildContext context}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      onSaved: onsave,
      validator: validate,
      style: Theme.of(context).textTheme.subtitle2,
      decoration: InputDecoration(
        hintText: hint,
        labelText: label,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black, width: 0.4),
          borderRadius: BorderRadius.circular(25.0),
        ),
        labelStyle: TextStyle(color: HexColor("#f1c771")),
        prefixIcon: Icon(
          prefix,
          color: HexColor("#f1c771"),
        ),
        suffixIcon: suffix != null
            ? IconButton(
          onPressed: suffixPressed,
          icon: Icon(
            suffix,
            color: HexColor("#f1c771"),
          ),
        )
            : null,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 0.4),
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
    );

Widget myDivider() => Padding(
  padding: const EdgeInsetsDirectional.only(
    start: 20.0,
  ),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: HexColor("#e8885b"),
  ),
);

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 3.0,
  @required Function function,
  @required String text,
  TextStyle style,
}) =>
    Container(
      width: width,
      height: 50.0,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: style,
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
    );

void navigateTo(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);

void navigateReplace(context, widget) => Navigator.pushReplacement(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);

void navigateAndFinish(
    context,
    widget,
    ) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
          (route) {
        return false;
      },
    );

Widget defaultTextButton({
  @required Function function,
  @required String text,
}) =>
    TextButton(
      onPressed: function,
      child: Text(
        text.toUpperCase(),
        style: TextStyle(color: Colors.black),
      ),
    );
