import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:practical/src/constants/colors.constants.dart';
import 'package:practical/src/constants/misc.constants.dart';

class CommonTextfield extends StatefulWidget {
  final TextFieldOption textOption;
  final Function(String text) textCallback;
  final VoidCallback? tapCallback;
  final VoidCallback? onNextPress;
  final TextInputAction? inputAction;
  final FocusNode? focusNode;
  final bool showUnderLine;
  final bool? enable;
  final bool autoCorrect;
  final bool filled;

  CommonTextfield(
      {required this.textOption,
      required this.textCallback,
      this.tapCallback,
      this.onNextPress,
      this.inputAction,
      this.focusNode,
      this.showUnderLine = true,
      this.enable = true,
      this.autoCorrect = true,
      this.filled = false});

  @override
  _CommonTextfieldState createState() => _CommonTextfieldState();
}

class _CommonTextfieldState extends State<CommonTextfield> {
  bool obscureText = false;
  IconData obscureIcon = Icons.visibility;

  @override
  void initState() {
    super.initState();

    obscureText = widget.textOption.isSecureTextField ?? false;
  }

  @override
  void didUpdateWidget(CommonTextfield oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Flexible(
            child: TextField(
              autocorrect: widget.autoCorrect,
              enabled: widget.enable,
              maxLines: widget.textOption.maxLine,
              textInputAction: widget.inputAction ?? TextInputAction.done,
              focusNode: widget.focusNode ?? null,
              controller: widget.textOption.inputController ?? null,
              obscureText: this.obscureText,
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
              keyboardType:
                  widget.textOption.keyboardType ?? TextInputType.text,
              cursorColor: accent,
              inputFormatters: widget.textOption.formatter ?? [],
              decoration: InputDecoration(
                filled: widget.filled,
                fillColor: widget.filled ? complimentry40 : Colors.transparent,
                enabledBorder: widget.showUnderLine == true
                    ? UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).dividerColor))
                    : UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: complimentry80!)),
                labelStyle: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    fontWeight: FontWeight.w600),
                labelText: widget.textOption.labelText,
                hintText: widget.textOption.hintText,
                hintStyle: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    fontWeight: FontWeight.w600),
                prefixIcon: widget.textOption.prefixWid,
                suffixIcon: (widget.textOption.suffixWid != null)
                    ? widget.textOption.suffixWid
                    : (widget.textOption.isSecureTextField != null &&
                            widget.textOption.isSecureTextField!)
                        ? IconButton(
                            icon: Icon(
                              obscureIcon,
                              color: complimentry80!.withAlpha(140),
                            ),
                            onPressed: () {
                              setState(() {
                                this.obscureText = !this.obscureText;
                                if (this.obscureText) {
                                  this.obscureIcon = Icons.visibility;
                                } else {
                                  this.obscureIcon = Icons.visibility_off;
                                }
                              });
                            },
                          )
                        : widget.textOption.type == TextFieldType.DropDown
                            ? IconButton(
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                ),
                                onPressed: () {},
                              )
                            : widget.textOption.type == TextFieldType.DateTime
                                ? IconButton(
                                    icon: Icon(
                                      Icons.calendar_today,
                                    ),
                                    onPressed: () {},
                                  )
                                : null,
              ),
              onSubmitted: (String text) {
                this.widget.textCallback(text);
                setFocus(context: context);
                if (widget.onNextPress != null) {
                  widget.onNextPress!();
                }
              },
              onChanged: (String text) {
                this.widget.textCallback(text);
              },
              onEditingComplete: () {
                this
                    .widget
                    .textCallback(widget.textOption.inputController!.text);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class TextFieldOption {
  String? text = "";
  String? labelText;
  String? hintText;
  bool? isSecureTextField = false;
  TextInputType? keyboardType;
  TextFieldType type;
  int maxLine;
  int maxLength;
  Widget? prefixWid;
  Widget? suffixWid;
  List<TextInputFormatter>? formatter;
  TextEditingController? inputController;

  TextFieldOption(
      {this.text,
      this.labelText,
      this.hintText,
      this.isSecureTextField,
      this.keyboardType,
      this.type = TextFieldType.Normal,
      this.maxLine = 1,
      this.maxLength = 200,
      this.formatter,
      this.inputController,
      this.prefixWid,
      this.suffixWid});
}

enum TextFieldType {
  Normal,
  DropDown,
  DateTime,
}
