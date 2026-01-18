/*
*Standard GoRouter navigation: context.goNamed(Routes.home.name);
* Navigate by Path: context.go(Routes.home.path);
* */
enum Routes {
  loading('/loading', 'loading'),
  onboarding('/onboarding', 'onboarding'),
  home('/', 'home'),
  login('/login', 'login'),
  signup('/sign-up', 'signup'),
  search('/search', 'search'),
  account('/account', 'account'),
  product('/products/:id', 'product');

  final String path;
  final String name;

  const Routes(this.path, this.name);
}