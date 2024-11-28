import '../app_utils/app_utils.dart';

extension StringExtension on String {
  String get imageOriginal {
    if (isEmpty) {
      return 'https://www.publicdomainpictures.net/pictures/280000/velka/not-found-image-15383864787lu.jpg';
    }
    return 'https://image.tmdb.org/t/p/original$this';
  }

  bool get isEmail => AppUtils.isEmail(this);

  bool get isPhoneNumber => AppUtils.isPhoneNumber(this);
}
