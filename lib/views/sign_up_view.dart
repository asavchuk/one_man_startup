import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:one_man_startup/services/auth_service.dart';
import 'package:one_man_startup/widgets/provider_vidget.dart';

final primaryColor = Color(0xFF75A2EA);

enum AuthFormType { signIn, signUp }

class SignUpView extends StatefulWidget {
  final AuthFormType authFormType;

  const SignUpView({Key key, this.authFormType}) : super(key: key);

  @override
  _SignUpViewState createState() => _SignUpViewState(authFormType: this.authFormType);
}

class _SignUpViewState extends State<SignUpView> {
  AuthFormType authFormType;
  _SignUpViewState({this.authFormType});

  final formKey = GlobalKey<FormState>();
  String _email, _password, _name, _error;

  void switchFormState(String state) {
    formKey.currentState.reset();
    if (state == 'signUp') {
      setState(() {
        authFormType = AuthFormType.signUp;
      });
    } else {
      setState(() {
        authFormType = AuthFormType.signIn;
      });
    }
  }

  bool validate() {
    final form = formKey.currentState;
    form.save();
    if (form.validate()) {
      return true;
    } else {
      return false;
    }
  }

  void submit() async {
    if (validate()) {
      try {
        final auth = Provider.of(context).auth;
        if (authFormType == AuthFormType.signIn) {
          String uid = await auth.singInWithEmailAndPassword(_email, _password);
          print('signed in with id $uid');
          Navigator.of(context).pushReplacementNamed('/home');
        } else {
          String uid = await auth.createUserWithEmailAndPassword(_email, _password, _name);
          print('signed up with new id $uid');
          Navigator.of(context).pushReplacementNamed('/home');
        }
      } catch (e) {
        print(e);
        setState(() {
          _error = e.message;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        color: primaryColor,
        height: _height,
        width: _width,
        child: SafeArea(
          child: Column(
            children: <Widget>[
              SizedBox(height: _height * 0.025),
              showAlert(),
              SizedBox(height: _height * 0.025),
              buildHeaderText(),
              SizedBox(height: _height * 0.05),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: buildInputs() + buildButtons(),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget showAlert() {
    if (_error != null) {
      return Container(
        color: Colors.amberAccent,
        width: double.infinity,
        padding: EdgeInsets.all(8),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(Icons.error_outline),
            ),
            Expanded(
              child: AutoSizeText(
                _error,
                maxLines: 3,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    _error = null;
                  });
                },
              ),
            )
          ],
        ),
      );
    }
    return SizedBox(height: 0);
  }

  AutoSizeText buildHeaderText() {
    String headerText;
    if (authFormType == AuthFormType.signUp) {
      headerText = 'Create new Account';
    } else {
      headerText = 'Sign In';
    }

    return AutoSizeText(
      headerText,
      maxLines: 1,
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.white, fontSize: 35),
    );
  }

  List<Widget> buildInputs() {
    List<Widget> textFields = [];

    if (authFormType == AuthFormType.signUp) {
      textFields.add(TextFormField(
        validator: NameValidator.validate,
        style: TextStyle(fontSize: 22),
        decoration: buildSignUpInputDecoration('Name'),
        onSaved: (value) => _name = value,
      ));
      textFields.add(SizedBox(height: 20));
    }

    textFields.add(TextFormField(
      validator: EmailValidator.validate,
      style: TextStyle(fontSize: 22),
      decoration: buildSignUpInputDecoration('Email'),
      onSaved: (value) => _email = value,
    ));
    textFields.add(SizedBox(height: 20));

    textFields.add(TextFormField(
      validator: PasswordValidator.validate,
      style: TextStyle(fontSize: 22),
      decoration: buildSignUpInputDecoration('Password'),
      obscureText: true,
      onSaved: (value) => _password = value,
    ));
    textFields.add(SizedBox(height: 20));

    return textFields;
  }

  InputDecoration buildSignUpInputDecoration(String hint) {
    return InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        focusColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 0.0),
        ),
        contentPadding: const EdgeInsets.only(left: 14, bottom: 10, top: 10));
  }

  List<Widget> buildButtons() {
    String switchButtonText, newFormState, submitButtonText;

    if (authFormType == AuthFormType.signIn) {
      switchButtonText = 'Create New Account';
      newFormState = 'signUp';
      submitButtonText = 'Sign In';
    } else {
      switchButtonText = 'Have An Account? Sign In';
      newFormState = 'signIn';
      submitButtonText = 'Sign Up';
    }
    return [
      Container(
        width: MediaQuery.of(context).size.width,
        child: RaisedButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          color: Colors.white,
          textColor: primaryColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              submitButtonText,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
            ),
          ),
          onPressed: () {
            submit();
          },
        ),
      ),
      FlatButton(
        onPressed: () {
          switchFormState(newFormState);
        },
        child: Text(
          switchButtonText,
          style: TextStyle(color: Colors.white),
        ),
      )
    ];
  }
}
