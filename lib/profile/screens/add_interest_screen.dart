// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_tag_editor/tag_editor.dart';
import 'package:youapp_flutter/components/fabric_back_button.dart';
import 'package:youapp_flutter/components/fabric_chip.dart';
import 'package:youapp_flutter/components/fabric_text.dart';
import 'package:youapp_flutter/components/floating_snackbar.dart';
import 'package:youapp_flutter/components/gradient_scaffold.dart';
import 'package:youapp_flutter/components/shadermask.dart';
import 'package:youapp_flutter/models/profile.dart';
import 'package:youapp_flutter/profile/bloc/profile_bloc.dart';

class AddInterestScreen extends StatefulWidget {
  const AddInterestScreen({super.key, required this.addedList});
  final List<String> addedList;
  @override
  State<AddInterestScreen> createState() => _AddInterestScreenState();
}

class _AddInterestScreenState extends State<AddInterestScreen> {
  List<String> _values = [];
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _textEditingController = TextEditingController();
  bool isLoading = false;
  _onDelete(index) {
    setState(() {
      _values.removeAt(index);
    });
  }

  @override
  void initState() {
    _values = widget.addedList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, stateProfile) {
        if (stateProfile is ProfileUpdateState) {
          setState(() {
            isLoading = false;
          });
          context.pop();
        }
        if (stateProfile is ProfileErrorState) {
          setState(() {
            isLoading = false;
          });
          FabricSnackbar.floatingSnackBar(
            context: context,
            textColor: Colors.black,
            textStyle: const TextStyle(color: Colors.white),
            duration: const Duration(milliseconds: 1500),
            backgroundColor: Colors.redAccent,
            content: Padding(
              padding: const EdgeInsets.only(top: 5, left: 10, bottom: 15),
              child: Text(
                stateProfile.error.message ?? "Something wrong please try again",
              ),
            ),
          );
        }
      },
      child: GradientScaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          scrolledUnderElevation: 0.0,
          backgroundColor: Colors.transparent,
          title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            FabricBackButton(
              onBackTap: () {
                context.pop();
              },
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  isLoading = true;
                });
                BlocProvider.of<ProfileBloc>(context).add(
                  ProfileUpdateEvent(
                    Profile(
                      interests: _values,
                    ),
                  ),
                );
              },
              child: isLoading
                  ? SizedBox(
                      width: 12,
                      height: 12,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    )
                  : BlueishShaderMask(
                      child: FabricText(
                        "Save",
                        style: InterTextStyle.body2(context),
                      ),
                    ),
            ),
          ]),
        ),
        body: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: GoldenShaderMask(
                  child: FabricText(
                    "Tell everyone about yourself",
                    style: InterTextStyle.body2(context),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: FabricText(
                  "What interest you?",
                  style: InterTextStyle.subtitle(context),
                ),
              ),
              SizedBox(
                height: 35,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.1),
                  borderRadius: BorderRadius.circular(9),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                child: TagEditor(
                  length: _values.length,
                  controller: _textEditingController,
                  focusNode: _focusNode,
                  delimiters: [',', ' '],
                  hasAddButton: false,
                  resetTextOnSubmitted: true,
                  textStyle: InterTextStyle.body1(context),
                  onSubmitted: (outstandingValue) {
                    setState(() {
                      _values.add(outstandingValue);
                    });
                  },
                  inputDecoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                  onTagChanged: (newValue) {
                    setState(() {
                      _values.add(newValue);
                    });
                  },
                  tagBuilder: (context, index) => FabricChip(
                    index: index,
                    label: _values[index],
                    onDeleted: _onDelete,
                  ),
                  inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'[/\\]'))],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
