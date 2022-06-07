import 'dart:math';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hci_manager/screen/drug/drug_view.dart';
import 'package:string_validator/string_validator.dart';

import '../../addons/breakpoint.dart';
import '../../models/drug.dart';
import '../../provider/global_method.dart';
import '../../responsive_layout.dart';
import 'drug_panel.dart';

final isOpenAddDrugProvider = StateProvider((_) => true);

class AddDrug extends ConsumerStatefulWidget {
  const AddDrug();

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddDrugState();
}

class _AddDrugState extends ConsumerState<AddDrug>
    with SingleTickerProviderStateMixin {
  Random rng = Random();
  double doubleInRange(Random source, num start, num end) =>
      source.nextDouble() * (end - start) + start;
  int next(int min, int max) => min + rng.nextInt(max - min);
  final idField = TextEditingController();
  final titleField = TextEditingController();
  final nameField = TextEditingController();
  final imgField = TextEditingController();
  final ingreField = TextEditingController();
  final priceField = TextEditingController();
  final usesField = TextEditingController();
  final containerField = TextEditingController();
  var brought = 0;
  var rating = 0.0;
  String type = 'A1';
  String url = '';
  String unit = 'Bottle';
  bool isAdd = true;
  var loadedDrug;
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.onUserInteraction;

  Widget blankWidget() => Padding(
        key: const Key('blankPane'),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SizedBox(
          height: 50,
          width: 50,
          child: Scaffold(
            backgroundColor: Colors.white,
            body: NeumorphicButton(
              style: const NeumorphicStyle(color: Colors.white),
              onPressed: () => ref.read(isOpenAddDrugProvider.notifier).state =
                  !ref.read(isOpenAddDrugProvider.notifier).state,
              child: const Center(
                child: Icon(
                  Icons.swipe_left_alt_sharp,
                  color: Colors.blue,
                ),
              ),
            ),
          ),
        ),
      );

  Widget mainWidget() => SizedBox(
        key: const Key('addDrugPanel'),
        width: Responsive.isDesktop(context) ? 400 : double.infinity,
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Add Drug',
              style: TextStyle(color: Colors.grey),
            ),
            backgroundColor: Colors.white,
            centerTitle: true,
            elevation: 0,
            leading: Responsive.isDesktop(context)
                ? IconButton(
                    onPressed: () =>
                        ref.read(isOpenAddDrugProvider.notifier).state =
                            !ref.read(isOpenAddDrugProvider.notifier).state,
                    icon: const Icon(
                      Icons.remove_circle_outline_rounded,
                      color: Colors.grey,
                    ))
                : const BackButton(color: Colors.grey),
            actions: [
              if (isAdd)
                IconButton(
                  onPressed: () => getDrugObj(),
                  icon: const Icon(
                    Icons.send,
                    color: Colors.blue,
                  ),
                ),
              if (!isAdd)
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        resetWid();
                      },
                      icon: const Icon(
                        Icons.clear,
                        color: Colors.red,
                      ),
                    ),
                    IconButton(
                      onPressed: () => getDrugObj(),
                      icon: const Icon(
                        Icons.published_with_changes_sharp,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                )
            ],
          ),
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            controller: ScrollController(),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        formFieldInput(
                            'Input ID', idField, 'Please fill the ID'),
                        formFieldInput('Input Title', titleField,
                            'Please fill the Title Field'),
                        formFieldInput('Input Full Name', nameField,
                            'Please fill drugs full name Field'),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 4,
                                        child: Neumorphic(
                                          margin: const EdgeInsets.symmetric(
                                              vertical: kSmallPadding),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          style: const NeumorphicStyle(
                                            color: Colors.white,
                                            intensity: 5,
                                          ),
                                          child: TextFormField(
                                            autovalidateMode: autovalidateMode,
                                            controller: imgField,
                                            validator: (v) {
                                              if (v == null ||
                                                  v.isEmpty ||
                                                  !Uri.parse(v)
                                                      .host
                                                      .isNotEmpty) {
                                                return 'Please fill the URL Field';
                                              }
                                              url = v;
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                              label:
                                                  const Text('Input Image URL'),
                                              labelStyle: const TextStyle(
                                                  color: Colors.grey),
                                              suffixIcon: IconButton(
                                                onPressed: imgField.clear,
                                                icon: const Icon(Icons.clear),
                                              ),
                                            ),
                                            cursorColor: Colors.grey,
                                            style: const TextStyle(
                                                color: Colors.black54),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          height: 50,
                                          child: NeumorphicButton(
                                            style: const NeumorphicStyle(
                                                color: Colors.blue),
                                            child: const Center(
                                                child: Text('Load Img')),
                                            onPressed: () {
                                              if (Uri.parse(url)
                                                  .host
                                                  .isNotEmpty) {
                                                setState(() {});
                                              } else {}
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  selectType(),
                                  selectUnit(),
                                ],
                              ),
                            ),
                            if (Responsive.isTablet(context))
                              SizedBox(
                                height: 180,
                                width: 180,
                                child: Neumorphic(
                                  style: const NeumorphicStyle(
                                      color: Colors.white, depth: 5),
                                  child: Center(
                                    child: url.isEmpty
                                        ? const Icon(
                                            Icons.image,
                                            color: Colors.grey,
                                          )
                                        : Image.network(url),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        if (!Responsive.isTablet(context))
                          SizedBox(
                            height: 180,
                            width: 180,
                            child: Neumorphic(
                              style: const NeumorphicStyle(
                                  color: Colors.white, depth: 5),
                              child: Center(
                                child: url.isEmpty
                                    ? const Icon(
                                        Icons.image,
                                        color: Colors.grey,
                                      )
                                    : Image.network(url),
                              ),
                            ),
                          ),
                        Neumorphic(
                          margin: const EdgeInsets.symmetric(
                              vertical: kSmallPadding),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          style: const NeumorphicStyle(
                            color: Colors.white,
                            intensity: 5,
                          ),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            autovalidateMode: autovalidateMode,
                            controller: priceField,
                            validator: (v) {
                              if (v == null || v.isEmpty || !isNumeric(v)) {
                                return 'Please fill the Field';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              label: const Text('Input Price'),
                              labelStyle: const TextStyle(color: Colors.grey),
                              suffixIcon: IconButton(
                                onPressed: priceField.clear,
                                icon: const Icon(Icons.clear),
                              ),
                            ),
                            cursorColor: Colors.grey,
                            style: const TextStyle(color: Colors.black54),
                          ),
                        ),
                        formFieldInput('Input Ingredient', ingreField,
                            'Please fill the Field'),
                        formFieldInput(
                            'Input Usage', usesField, 'Please fill the Field'),
                        formFieldInput('Input Container', containerField,
                            'Please fill the Field'),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    height: 100,
                    width: 200,
                    child: NeumorphicButton(
                      style: const NeumorphicStyle(
                          color: Colors.white, depth: 5, intensity: 0.8),
                      onPressed: () {
                        if (isAdd) {
                          getDrugObj();
                        } else {
                          getDrugObj();
                        }
                      },
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                                isAdd
                                    ? Icons.send
                                    : Icons.published_with_changes_sharp,
                                color: Colors.blue),
                            const SizedBox(width: 10),
                            Text(
                              isAdd ? 'Send' : 'Update',
                              style: const TextStyle(
                                  color: Colors.blue, fontSize: 18),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );

  void resetWid() {
    isAdd = true;
    ref.refresh(drugLoadProvider.notifier);
    if (!Responsive.isDesktop(context)) {
      ref.read(DrawerKeyProvider.notifier).state.currentState!.closeEndDrawer();
    }
  }

  void loadDummy() {
    final tempDrug = ref.watch(drugLoadProvider);
    if (tempDrug == loadedDrug) {
      return;
    } else {
      loadedDrug = tempDrug;
      idField.text = loadedDrug.id;
      titleField.text = loadedDrug.title;
      nameField.text = loadedDrug.fullName;
      imgField.text = loadedDrug.imgUrl;
      ingreField.text = loadedDrug.ingredients;
      priceField.text = loadedDrug.price.toString();
      usesField.text = loadedDrug.uses;
      containerField.text = loadedDrug.container;
      type = loadedDrug.type;
      unit = loadedDrug.unit;
      url = loadedDrug.imgUrl;
      if (loadedDrug.id != '') isAdd = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    bool currentShow = ref.watch(isOpenAddDrugProvider);
    loadDummy();
    return Neumorphic(
      style: NeumorphicStyle(
        depth: currentShow ? 5 : 0,
        color: Colors.white,
        lightSource: LightSource.right,
      ),
      child: AnimatedAlign(
        duration: const Duration(milliseconds: 350),
        alignment: currentShow ? Alignment.centerLeft : Alignment.topRight,
        child: AnimatedSize(
          duration: const Duration(milliseconds: 350),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 350),
            child: currentShow ? mainWidget() : blankWidget(),
          ),
        ),
      ),
    );
  }

  void getDrugObj() {
    try {
      String title = titleField.text;
      String name = nameField.text;
      String id = idField.text;
      String img = imgField.text;
      String ingredients = ingreField.text;
      String uses = usesField.text;
      double price = double.parse(priceField.text);
      String container = containerField.text;
      rating = doubleInRange(rng, 0, 5);
      brought = next(5, 200);
      if (title.isEmpty ||
          name.isEmpty ||
          id.isEmpty ||
          img.isEmpty ||
          ingredients.isEmpty ||
          uses.isEmpty ||
          container.isEmpty ||
          price == 0 ||
          type == 'null' ||
          unit == 'null') {
        throw Error();
      }
      Drug drug = Drug(
        title: title,
        fullName: name,
        id: id,
        unit: unit,
        price: price,
        imgUrl: img,
        type: type,
        ingredients: ingredients,
        uses: uses,
        rating: rating,
        brought: brought,
        container: container,
      );
      String msg = '';
      String tit = '';
      if (isAdd) {
        submitToDB(drug);
        tit = 'New Drug Added';
        msg = '$unit of $title has been succesful added';
      } else {
        updateToDB(drug);
        tit = 'Drug Updated';
        msg = '$unit of $title has been succesful updated';
      }
      var snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: tit,
          message: msg,
          contentType: ContentType.success,
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      resetWid();
      _formKey.currentState!.reset();
    } catch (e) {
      var snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'On Snap!',
          message: 'Invalid value inputed, Please check it again',
          contentType: ContentType.failure,
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Widget selectType() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: kSmallPadding),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (Responsive.isTablet(context))
            const Text(
              'Select Type:',
              style: TextStyle(color: Colors.grey, fontSize: 18),
            ),
          neumorRadio('A1', 'A1: Drug', 'type'),
          neumorRadio('A2', 'A2: Medical Equipment', 'type'),
        ],
      ),
    );
  }

  Widget selectUnit() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: kSmallPadding),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (Responsive.isTablet(context))
            const Text(
              'Select Unit:',
              style: TextStyle(color: Colors.grey, fontSize: 18),
            ),
          neumorRadio('Bottle', 'Bottle', unit),
          neumorRadio('Tablet', 'Tablet', unit),
          neumorRadio('Powder ', 'Powder ', unit),
          neumorRadio('Tube', 'Tube', unit),
          neumorRadio('Item', 'Item', unit),
        ],
      ),
    );
  }

  NeumorphicRadio<String> neumorRadio(String val, String txt, String grVal) {
    return NeumorphicRadio(
      style: const NeumorphicRadioStyle(
          selectedColor: Colors.blue, unselectedColor: Colors.white),
      value: val,
      groupValue: grVal == 'type' ? type : unit,
      onChanged: (value) {
        setState(() {
          if (grVal == 'type') {
            ref.read(drugLoadProvider.notifier).state.type = value.toString();
            type = value.toString();
          } else {
            ref.read(drugLoadProvider.notifier).state.unit = value.toString();
            unit = value.toString();
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        height: 50,
        child: Center(
          child: Text(
            txt,
            style: const TextStyle(
                color: Colors.black,
                letterSpacing: 1,
                fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }

  Neumorphic formFieldInput(
      String label, TextEditingController controller, String vali) {
    return Neumorphic(
      margin: const EdgeInsets.symmetric(vertical: kSmallPadding),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      style: const NeumorphicStyle(
        color: Colors.white,
        intensity: 5,
      ),
      child: TextFormField(
        autovalidateMode: autovalidateMode,
        controller: controller,
        validator: (v) {
          if (v == null || v.isEmpty) {
            return vali;
          }
          return null;
        },
        decoration: InputDecoration(
          label: Text(label),
          labelStyle: const TextStyle(color: Colors.grey),
          suffixIcon: IconButton(
            onPressed: controller.clear,
            icon: const Icon(Icons.clear),
          ),
        ),
        cursorColor: Colors.grey,
        style: const TextStyle(color: Colors.black54),
      ),
    );
  }
}
