import 'package:dartz/dartz.dart';

import '../../../../errors/failure.dart';
import '../../../../usecases/base_usecase.dart';
import '../repositories/theme_repository.dart';

class ChangeThemeUseCase implements BaseUseCase<bool, String> {
  final ThemeRepository themeRepository;
  ChangeThemeUseCase({
    required this.themeRepository,
  });

  @override
  Future<Either<Failure, bool>> call(String params) async {
    return await themeRepository.changeTheme(themeMode: params);
  }
}
