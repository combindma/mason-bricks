/*
*Standard GoRouter navigation: context.goNamed(Routes.home.name);
* Navigate by Path: context.go(Routes.home.path);
* */
enum Routes {
  loading('/loading', 'loading'),
  onboarding('/onboarding', 'onboarding'),
  welcome('/welcome', 'welcome'),
  login('/login', 'login'),
  loginForm('/form', 'login_form'),
  signup('/sign-up', 'signup'),
  signupForm('/form', 'signup_form'),
  home('/', 'home'),
  search('/search', 'search'),
  account('/account', 'account'),
  editProfile('/account/update', 'edit_profile'),
  deleteAccount('/account/delete', 'delete_account');
  //product('/products/:id', 'product');

  final String path;
  final String name;

  const Routes(this.path, this.name);
}