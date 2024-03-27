import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snowglobe/images_state.dart';

class PrefsTab extends StatefulWidget {
  const PrefsTab({super.key});

  @override
  State<StatefulWidget> createState() => _PrefsState();
}

class _PrefsState extends State<PrefsTab> {
  final TextEditingController _controller = TextEditingController();
  final GlobalKey<FormState> _formExampleKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Consumer<ImagesState>(builder: (context, state, child) {
      return Form(
          key: _formExampleKey,
          child: ListView(
            children: [
              Text('Preferences',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontWeight: FontWeight.bold)),
              ListTile(
                title: TextFormField(
                  controller: _controller,
                  autofocus: true,
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Number of snowflakes',
                      hintText: '${state.numFlakes}'),
                  onSaved: (value) {
                    if (null != value) {
                      state.setNumFlakes(int.parse(value));
                    }
                  },
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    final state = _formExampleKey.currentState;
                    if (state!.validate()) {
                      setState(() {
                        state.save();
                      });
                    }
                  },
                  child: const Text('Save'))
            ],
          ));
    });
  }
}
