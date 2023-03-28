import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_flutter/common/extension/custom_theme_extension.dart';
import 'package:whatsapp_flutter/common/helpers/show_alert_dialog.dart';
import 'package:whatsapp_flutter/common/utils/my_colors.dart';
import 'package:whatsapp_flutter/common/widgets/custom_elevated_button.dart';
import 'package:whatsapp_flutter/feature/auth/controller/auth_controller.dart';
import 'package:whatsapp_flutter/feature/auth/widgets/custom_icon_button.dart';
import 'package:whatsapp_flutter/feature/auth/widgets/custom_text_field.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  late TextEditingController countryNameController;
  late TextEditingController countryCodeController;
  late TextEditingController phoneNumberController;

  sendCodeToPhone() {
    final phoneNumber = phoneNumberController.text;
    final countryName = countryNameController.text;
    final countryCode = countryCodeController.text;

    if (phoneNumber.isEmpty) {
      return showAlertDialog(
        context: context,
        message: 'Please enter your phone number',
      );
    } else if (phoneNumber.length < 9) {
      return showAlertDialog(
        context: context,
        message:
            'Phone number too short.\n\nInclude your area code if you haven\'t',
      );
    } else if (phoneNumber.length > 9) {
      return showAlertDialog(
        context: context,
        message:
            'Phone number too long.\n\nInclude your area code if you haven\'t',
      );
    }

    ref.read(authControllerProvider).sendSmsCode(
          context: context,
          phoneNumber: '$countryCode$phoneNumber',
        );
  }

  showCountryCodePicker() {
    showCountryPicker(
      context: context,
      showPhoneCode: true,
      favorite: ['AO'],
      countryListTheme: CountryListThemeData(
        bottomSheetHeight: 600,
        backgroundColor: Theme.of(context).colorScheme.background,
        flagSize: 22,
        borderRadius: BorderRadius.circular(20),
        textStyle: TextStyle(color: context.theme.greyColor),
        inputDecoration: InputDecoration(
          labelStyle: TextStyle(color: context.theme.greyColor),
          prefixIcon: const Icon(
            Icons.language,
            color: MyColors.greenDark,
          ),
          hintText: 'Search country code or name',
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
            color: context.theme.greyColor!.withOpacity(.2),
          )),
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
            color: MyColors.greenDark,
          )),
        ),
      ),
      onSelect: (country) {
        countryNameController.text = country.name;
        countryCodeController.text = country.phoneCode;
      },
    );
  }

  @override
  void initState() {
    countryNameController = TextEditingController(text: 'Angola');
    countryCodeController = TextEditingController(text: '244');
    phoneNumberController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    countryNameController.dispose();
    countryCodeController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Text(
          'Enter your phone\'s number',
          style: TextStyle(
            color: context.theme.authAppbarTextColor,
          ),
        ),
        actions: [
          CustomIconButton(
            onTap: () {},
            iconData: Icons.more_vert,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: 'WhatsApp will need to verify your number. ',
                style: TextStyle(
                  color: context.theme.greyColor,
                  height: 1.5,
                ),
                children: [
                  TextSpan(
                    text: "What's my number?",
                    style: TextStyle(
                      color: context.theme.blueColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: CustomTextField(
              onTap: showCountryCodePicker,
              controller: countryNameController,
              readOnly: true,
              suffixIcon: const Icon(
                Icons.arrow_drop_down,
                color: MyColors.greenDark,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Row(
              children: [
                SizedBox(
                  width: 70,
                  child: CustomTextField(
                    onTap: showCountryCodePicker,
                    controller: countryCodeController,
                    prefixText: '+',
                    readOnly: true,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: CustomTextField(
                    controller: phoneNumberController,
                    hintText: 'phone number',
                    textAlign: TextAlign.left,
                    keyboardType: TextInputType.number,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Carrier charges may apply',
            style: TextStyle(
              color: context.theme.greyColor,
            ),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CustomElevatedButton(
        onPressed: sendCodeToPhone,
        text: 'NEXT',
        buttonWidth: 90,
      ),
    );
  }
}
