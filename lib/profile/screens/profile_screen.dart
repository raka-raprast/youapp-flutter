// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:age_calculator/age_calculator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:youapp_flutter/auth/bloc/auth_bloc.dart';
import 'package:youapp_flutter/chinese_zodiac.dart';
import 'package:youapp_flutter/components/fabric_chip.dart';
import 'package:youapp_flutter/components/fabric_text.dart';
import 'package:youapp_flutter/components/floating_snackbar.dart';
import 'package:youapp_flutter/components/shadermask.dart';
import 'package:youapp_flutter/components/svg_icon.dart';
import 'package:youapp_flutter/components/text_field.dart';
import 'package:youapp_flutter/gen/assets.gen.dart';
import 'package:youapp_flutter/horoscope.dart';
import 'package:youapp_flutter/models/profile.dart';
import 'package:youapp_flutter/profile/bloc/profile_bloc.dart';
import 'package:youapp_flutter/profile/bloc/update_profile_bloc.dart';
import 'package:youapp_flutter/profile/screens/add_interest_screen.dart';
import 'package:youapp_flutter/utils.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
  });
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with TickerProviderStateMixin {
  bool isCollapsed = true, isChanges = false;
  DateTime? birthday;
  TextEditingController nameCtr = TextEditingController();
  TextEditingController birthdayCtr = TextEditingController();
  TextEditingController zodiacCtr = TextEditingController();
  TextEditingController horoscopeCtr = TextEditingController();
  TextEditingController heightCtr = TextEditingController();
  TextEditingController weightCtr = TextEditingController();
  TextEditingController genderCtr = TextEditingController();
  File? selectedPhoto;
  final dayFormat = DateFormat('dd MM yyyy');
  final fixedDateFormat = DateFormat('dd/MM/yyyy');
  @override
  Widget build(BuildContext context) {
    var auth = BlocProvider.of<AuthBloc>(context);
    return BlocConsumer<ProfileBloc, ProfileState>(listener: (context, stateProfile) {
      if (stateProfile is ProfileFetchState) {
        setState(() {
          isChanges = false;
        });
        var profile = stateProfile.profile;

        if (profile.name != null && profile.name!.isNotEmpty) {
          setState(() {
            nameCtr.text = profile.name!;
          });
        }
        if (profile.birthday != null && profile.birthday!.isNotEmpty) {
          setState(() {
            birthdayCtr.text = dayFormat.format(
              DateTime.parse(profile.birthday!),
            );
          });
        }
        if (profile.horoscope != null && profile.horoscope!.isNotEmpty) {
          setState(() {
            horoscopeCtr.text = profile.horoscope!;
          });
        }
        if (profile.zodiac != null && profile.zodiac!.isNotEmpty) {
          setState(() {
            zodiacCtr.text = profile.zodiac!;
          });
        }
        if (profile.height != null && profile.height != 0) {
          setState(() {
            heightCtr.text = "${profile.height}";
          });
        }
        if (profile.weight != null && profile.weight != 0) {
          setState(() {
            weightCtr.text = "${profile.weight}";
          });
        }
        if (profile.gender != null && profile.gender!.isNotEmpty) {
          setState(() {
            genderCtr.text = profile.gender!;
          });
        }
      }
      if (stateProfile is ProfileUpdateState) {
        setState(() {
          isChanges = false;
        });
        FabricSnackbar.floatingSnackBar(
          context: context,
          textColor: Colors.black,
          textStyle: const TextStyle(color: Colors.black),
          duration: const Duration(milliseconds: 1500),
          backgroundColor: FabricColors.background1,
          content: const Padding(
            padding: EdgeInsets.only(top: 5, left: 10, bottom: 15),
            child: Text(
              "Successfully updated profile",
            ),
          ),
        );
      }
    }, builder: (context, stateProfile) {
      return BlocConsumer<UpdateProfileBloc, UpdateProfileState>(listener: (context, stateUP) {
        if (stateUP is UpdateProfileUpdateImageState && stateProfile is ProfileFetchState) {
          BlocProvider.of<ProfileBloc>(context).add(ProfileFetchEvent());
        }
      }, builder: (context, stateUP) {
        return Scaffold(
          backgroundColor: FabricColors.background3,
          appBar: AppBar(
            scrolledUnderElevation: 0.0,
            backgroundColor: Colors.transparent,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 20,
                ),
                // FabricBackButton(
                //   onBackTap: () {},
                // ),
                FabricText(
                  "@${auth.user!.username}",
                  style: InterTextStyle.button(
                    context,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    showModalBottomSheet(
                      context: context,
                      isDismissible: true,
                      backgroundColor: FabricColors.background3,
                      builder: (context) {
                        return IntrinsicHeight(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    FabricSnackbar.floatingSnackBar(
                                      context: context,
                                      textColor: Colors.black,
                                      textStyle: const TextStyle(color: Colors.red),
                                      duration: const Duration(milliseconds: 1500),
                                      backgroundColor: FabricColors.background1,
                                      content: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(top: 5, left: 10, bottom: 15),
                                              child: Text(
                                                "Successfully logged out",
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                            },
                                            child: Icon(Icons.close_rounded),
                                          )
                                        ],
                                      ),
                                    );
                                    BlocProvider.of<AuthBloc>(context).add(AuthLogOutEvent());
                                    context.pop();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                                    child: FabricText(
                                      "Logout",
                                      style: InterTextStyle.body2(context),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    context.pop();
                                  },
                                  child: FabricText(
                                    "Cancel",
                                    style: InterTextStyle.body2(context),
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: SvgIcon(
                    svg: Assets.lib.assets.svgs.moreHoriz,
                  ),
                )
              ],
            ),
          ),
          body: RefreshIndicator(
            color: Colors.white,
            backgroundColor: Colors.transparent,
            onRefresh: () async {
              BlocProvider.of<ProfileBloc>(context).add(ProfileFetchEvent());
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: ListView(
                children: [
                  Container(
                    height: Sizes.height(context) * .25,
                    width: Sizes.width(context),
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: FabricColors.container1,
                      borderRadius: BorderRadius.circular(
                        16,
                      ),
                      image: stateProfile is ProfileFetchState && stateProfile.profile.imageUrl != null && stateProfile.profile.imageUrl!.isNotEmpty
                          ? DecorationImage(
                              opacity: .6,
                              fit: BoxFit.fill,
                              image: NetworkImage(
                                stateProfile.profile.imageUrl!,
                              ),
                            )
                          : null,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: FabricText(
                            "@${auth.user!.username}",
                            style: InterTextStyle.button(
                              context,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        if (stateProfile is ProfileFetchState && stateProfile.profile.gender != null && stateProfile.profile.gender!.isNotEmpty) ...[
                          SizedBox(
                            height: 5,
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: FabricText(
                              "${stateProfile.profile.gender}",
                              style: InterTextStyle.body1(
                                context,
                              ),
                            ),
                          ),
                        ],
                        Row(
                          children: [
                            if (stateProfile is ProfileFetchState && stateProfile.profile.horoscope != null && stateProfile.profile.horoscope!.isNotEmpty) ...[
                              FabricChip(
                                backgroundColor: FabricColors.container2,
                                borderRadius: BorderRadius.circular(999),
                                label: stateProfile.profile.horoscope!,
                                fontWeight: FontWeight.bold,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                            ],
                            if (stateProfile is ProfileFetchState && stateProfile.profile.zodiac != null && stateProfile.profile.zodiac!.isNotEmpty)
                              FabricChip(
                                backgroundColor: FabricColors.container2,
                                borderRadius: BorderRadius.circular(999),
                                label: stateProfile.profile.zodiac!,
                                fontWeight: FontWeight.bold,
                              )
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  AnimatedSize(
                    duration: Duration(milliseconds: 300),
                    alignment: Alignment.topCenter,
                    curve: Curves.fastOutSlowIn,
                    child: Container(
                      width: Sizes.width(context),
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      decoration: BoxDecoration(
                        color: FabricColors.container2,
                        borderRadius: BorderRadius.circular(
                          16,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FabricText(
                                "About",
                                style: InterTextStyle.body2(
                                  context,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (!isCollapsed) {
                                    if (selectedPhoto != null) {
                                      BlocProvider.of<UpdateProfileBloc>(context).add(UpdateProfileChangeProfileImageEvent(selectedPhoto!));
                                    }
                                    if ((birthday != null || nameCtr.text.isNotEmpty || heightCtr.text.isNotEmpty || weightCtr.text.isNotEmpty) && isChanges) {
                                      BlocProvider.of<ProfileBloc>(context).add(
                                        ProfileUpdateEvent(
                                          Profile(
                                            name: nameCtr.text.isNotEmpty ? nameCtr.text : '',
                                            birthday: birthday != null ? birthday.toString() : '',
                                            height: heightCtr.text.isNotEmpty ? int.tryParse(heightCtr.text) ?? 0 : 0,
                                            weight: weightCtr.text.isNotEmpty ? int.tryParse(weightCtr.text) ?? 0 : 0,
                                            interests: [],
                                            horoscope: horoscopeCtr.text.isNotEmpty ? horoscopeCtr.text : '',
                                            zodiac: zodiacCtr.text.isNotEmpty ? zodiacCtr.text : '',
                                            gender: genderCtr.text.isNotEmpty ? genderCtr.text : '',
                                          ),
                                        ),
                                      );
                                    }
                                  }
                                  setState(() {
                                    isCollapsed = !isCollapsed;
                                  });
                                },
                                child: stateProfile is ProfileLoadingState || stateUP is UpdateProfileLoadingState
                                    ? SizedBox(
                                        width: 12,
                                        height: 12,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                      )
                                    : isCollapsed
                                        ? SvgIcon(svg: Assets.lib.assets.svgs.edit)
                                        : GoldenShaderMask(
                                            child: FabricText(
                                            "Save & Update",
                                            style: InterTextStyle.body2(context, fontWeight: FontWeight.w600),
                                          )),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          stateProfile is ProfileFetchState
                              ? _buildAboutContent(context, stateProfile.profile, stateProfile.profile.isNotEmpty)
                              : SizedBox(
                                  height: 20,
                                ),
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    width: Sizes.width(context),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    decoration: BoxDecoration(
                      color: FabricColors.container2,
                      borderRadius: BorderRadius.circular(
                        16,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FabricText(
                              "Interest",
                              style: InterTextStyle.body2(
                                context,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddInterestScreen(
                                      addedList: stateProfile is ProfileFetchState ? stateProfile.profile.interests : [],
                                    ),
                                  ),
                                );
                              },
                              child: SvgIcon(svg: Assets.lib.assets.svgs.edit),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        stateProfile is ProfileFetchState && stateProfile.profile.interests.isNotEmpty
                            ? Wrap(
                                children: stateProfile.profile.interests
                                    .map((e) => Padding(
                                          padding: EdgeInsets.only(right: 10),
                                          child: FabricChip(
                                            backgroundColor: Colors.white.withOpacity(.1),
                                            borderRadius: BorderRadius.circular(999),
                                            label: e,
                                          ),
                                        ))
                                    .toList(),
                              )
                            : FabricText(
                                "Add in your interest to find a better match",
                                style: InterTextStyle.body2(context, color: Colors.white.withOpacity(.5)),
                              ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      });
    });
  }

  Widget _buildAboutContent(BuildContext context, Profile profile, bool isNotEmpty) {
    if (isNotEmpty && isCollapsed) {
      return Column(
        children: [
          _buildListItem(
              "Birthday: ",
              profile.birthday == null || (profile.birthday != null && profile.birthday!.isEmpty)
                  ? "-"
                  : "${fixedDateFormat.format(
                      DateTime.parse(profile.birthday!),
                    )}(Age ${AgeCalculator.age(
                      DateTime.parse(profile.birthday!),
                    ).years})",
              false),
          _buildListItem("Horoscope: ", profile.horoscope != null && profile.horoscope!.isNotEmpty ? profile.horoscope! : "-", false),
          _buildListItem("Zodiac: ", profile.zodiac != null && profile.zodiac!.isNotEmpty ? profile.zodiac! : "-", false),
          _buildListItem("Height: ", profile.height != null && profile.height != 0 ? "${profile.height} cm" : "-", false),
          _buildListItem("Weight: ", profile.weight != null && profile.weight != 0 ? "${profile.weight} kg" : "-", true),
        ],
      );
    } else if (!isCollapsed) {
      return Column(
        children: [
          GestureDetector(
            onTap: () async {
              final ImagePicker picker = ImagePicker();
              final XFile? image = await picker.pickImage(source: ImageSource.gallery, imageQuality: 25);
              if (image != null) {
                CroppedFile? croppedFile = await ImageUtils.cropImage(File(image.path));
                if (croppedFile != null) {
                  setState(() {
                    selectedPhoto = File(croppedFile.path);
                  });
                }
              }
            },
            child: Row(
              children: [
                Container(
                  width: Sizes.width(context) * .15,
                  height: Sizes.width(context) * .15,
                  margin: EdgeInsets.only(left: 5),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.1),
                    borderRadius: BorderRadius.circular(
                      17,
                    ),
                  ),
                  child: selectedPhoto != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(
                            17,
                          ),
                          child: Image.file(
                            selectedPhoto!,
                            fit: BoxFit.cover,
                          ),
                        )
                      : GoldenShaderMask(
                          child: Icon(
                          Icons.add,
                          size: Sizes.width(context) * .1,
                        )),
                ),
                SizedBox(
                  width: Sizes.width(context) * .05,
                ),
                FabricText(
                  "Add Image",
                  style: InterTextStyle.body2(context, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          _buildField("Display Name:", "Enter name", controller: nameCtr),
          _buildField("Gender:", "Select Gender", controller: genderCtr, isDropdown: true, readOnly: true, onTap: () {
            showModalBottomSheet(
              context: context,
              isDismissible: true,
              backgroundColor: FabricColors.background3,
              builder: (context) {
                return IntrinsicHeight(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      FabricText(
                        "Gender",
                        style: InterTextStyle.body2(
                          context,
                          color: Colors.white.withOpacity(
                            .4,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isChanges = true;
                            genderCtr.text = "Male";
                          });
                          context.pop();
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                          child: Row(
                            children: [
                              FabricText(
                                "Male",
                                style: InterTextStyle.body2(context),
                              ),
                              Icon(
                                Icons.male,
                                color: Colors.white,
                                size: 24,
                              )
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isChanges = true;
                            genderCtr.text = "Female";
                          });
                          context.pop();
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                          child: Row(
                            children: [
                              FabricText(
                                "Female",
                                style: InterTextStyle.body2(context),
                              ),
                              Icon(
                                Icons.female,
                                color: Colors.white,
                                size: 24,
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                );
              },
            );
          }),
          _buildField("Birthday:", "DD MM YYYY", controller: birthdayCtr, readOnly: true, onTap: () {
            showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900, 1, 1),
              lastDate: DateTime.now(),
              builder: (context, child) {
                return Theme(
                    data: Theme.of(context).copyWith(
                      colorScheme: ColorScheme.light(primary: FabricColors.golden2, onPrimary: FabricColors.background2, onSurface: Colors.white, surface: FabricColors.background3),
                      textButtonTheme: TextButtonThemeData(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ),
                    child: child!);
              },
            ).then((value) {
              if (value != null) {
                zodiacCtr.text = ChineseZodiac.getChineseZodiac(value);
                horoscopeCtr.text = Horoscope.getZodiacSign(value);
                birthdayCtr.text = "${value.day} ${value.month.toString().length > 1 ? value.month : "0${value.month}"} ${value.year}";
                setState(() {
                  birthday = value;
                });
              }
            });
          }),
          _buildField(
            "Horoscope:",
            "--",
            readOnly: true,
            controller: horoscopeCtr,
          ),
          _buildField(
            "Zodiac:",
            "--",
            readOnly: true,
            controller: zodiacCtr,
          ),
          _buildField(
            "Height:",
            "Add height",
            controller: heightCtr,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            suffixWidget: heightCtr.text.isNotEmpty ? FabricText(" cm") : null,
          ),
          _buildField(
            "Weight:",
            "Add weight",
            controller: weightCtr,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            suffixWidget: weightCtr.text.isNotEmpty ? FabricText(" kg") : null,
          ),
        ],
      );
    }
    return FabricText(
      "Add in your information to help others know you better",
      style: InterTextStyle.body2(context, color: Colors.white.withOpacity(.5)),
    );
  }

  Widget _buildListItem(String title, String data, bool isLast) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 5),
      child: Row(
        children: [
          FabricText(
            title,
            style: InterTextStyle.body2(
              context,
              color: Colors.white.withOpacity(.4),
            ),
          ),
          FabricText(data),
        ],
      ),
    );
  }

  Widget _buildField(
    String fieldName,
    String fieldHint, {
    TextEditingController? controller,
    bool readOnly = false,
    bool isDropdown = false,
    Function()? onTap,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    Widget? suffixWidget,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FabricText(
            fieldName,
            style: InterTextStyle.body1(context, color: Colors.white.withOpacity(.4)),
          ),
          SizedBox(
            width: Sizes.width(context) * .6,
            child: FabricTextField(
              onChanged: (s) {
                setState(() {
                  isChanges = true;
                });
              },
              suffixWidget: suffixWidget,
              height: 40,
              inputFormatters: inputFormatters,
              keyboardType: keyboardType,
              controller: controller,
              onTap: onTap,
              readOnly: readOnly,
              isDropdown: isDropdown,
              outlineColor: Colors.white.withOpacity(.3),
              backgroundColor: FabricColors.outline1.withOpacity(.1),
              hintText: fieldHint,
              style: InterTextStyle.body1(context),
              textAlign: TextAlign.end,
              hintStyle: InterTextStyle.body1(context, color: Colors.white.withOpacity(.3)),
            ),
          ),
        ],
      ),
    );
  }
}
