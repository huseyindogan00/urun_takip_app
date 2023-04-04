import 'package:flutter/material.dart';
import 'package:urun_takip_app/data/models/product_model.dart';
import 'package:urun_takip_app/ui/components/common/custom_appbar_widget.dart';

class DoWorkView extends StatefulWidget {
  const DoWorkView({super.key, required this.productModel});

  final ProductModel productModel;

  @override
  State<DoWorkView> createState() => _DoWorkViewState();
}

class _DoWorkViewState extends State<DoWorkView> {
  late final ProductModel _productModel;
  late TextEditingController _companyNameController;
  bool isActive = false;
  int tapped = 0;
  int currentStep = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _companyNameController = TextEditingController();
    _productModel = widget.productModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbarWidget(title: 'İş Yap'),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
              child: Stepper(
                controlsBuilder: (context, details) {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Flexible(
                          child: Container(
                            width: 100,
                            height: 40,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.grey.shade400),
                              onPressed: () {
                                _buildStepController(StepEnum.CONTINUE);
                              },
                              child: Text(
                                'İleri',
                                style: Theme.of(context).textTheme.headlineSmall,
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          child: Container(
                            width: 100,
                            height: 40,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.grey.shade400),
                              onPressed: () {
                                _buildStepController(StepEnum.CANCEL);
                              },
                              child: Text(
                                'Geri',
                                style: Theme.of(context).textTheme.headlineSmall,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                onStepTapped: (value) => setState(() {
                  tapped = value;
                }),
                currentStep: currentStep,
                elevation: 5,
                steps: [
                  Step(
                    state: StepState.editing,
                    isActive: isActive,
                    label: const Text('label adı'),
                    title: const Text('Alıcı Firma Adı'),
                    content: TextField(controller: _companyNameController),
                  ),
                  Step(
                    state: StepState.indexed,
                    isActive: isActive,
                    label: const Text('label adı'),
                    title: const Text('Alıcı Firma Adı'),
                    content: TextField(controller: _companyNameController),
                  ),
                  Step(
                    state: StepState.indexed,
                    isActive: isActive,
                    label: const Text('label adı'),
                    title: const Text('Alıcı Firma Adı'),
                    content: TextField(controller: _companyNameController),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildStepController(StepEnum whichStep) {
    switch (whichStep) {
      case StepEnum.CONTINUE:
        setState(() {
          currentStep++;
        });
        break;
      case StepEnum.CANCEL:
        setState(() {
          currentStep--;
        });

        break;
    }
  }
}

enum StepEnum {
  CANCEL,
  CONTINUE,
}

enum StepStateEnum { COMPLATE, EDITING, INDEXED }
