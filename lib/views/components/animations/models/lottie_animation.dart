//utilizes enhanced enumeration to create a list of animations that can be used in the app
enum LottieAnimation {
  dataNotFound(name: 'data_not_found'),
  empty(name: 'empty'),
  loading(name: 'loading'),
  error(name: 'error'),
  smallError(name: 'small_error');

  final String name;
  const LottieAnimation({
    required this.name,
  });
}
