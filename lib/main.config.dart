// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i4;
import 'package:firebase_auth/firebase_auth.dart' as _i3;
import 'package:firebase_storage/firebase_storage.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart'
    as _i6;

import 'data/api/auth_api/auth_api.dart' as _i7;
import 'data/api/auth_api/auth_api_impl.dart' as _i8;
import 'data/di/dependency_module.dart' as _i18;
import 'data/repository/auth_repository/auth_repo.dart' as _i11;
import 'data/repository/auth_repository/auth_repo_impl.dart' as _i12;
import 'data/shared_preferences/shared_preferences_module.dart' as _i9;
import 'data/shared_preferences/shared_preferences_module_impl.dart' as _i10;
import 'data/usecases/auth_use_case.dart' as _i13;
import 'data/usecases/auth_use_case_impl.dart' as _i14;
import 'feature/initial/initila_vm.dart' as _i15;
import 'feature/login/login_vm.dart' as _i16;
import 'feature/main/main_vm.dart' as _i17;

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// initializes the registration of main-scope dependencies inside of GetIt
Future<_i1.GetIt> $initGetIt(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final dependencyModule = _$DependencyModule();
  gh.lazySingleton<_i3.FirebaseAuth>(() => dependencyModule.auth());
  gh.lazySingleton<_i4.FirebaseFirestore>(() => dependencyModule.firestore());
  gh.lazySingleton<_i5.FirebaseStorage>(() => dependencyModule.storage());
  await gh.factoryAsync<_i6.StreamingSharedPreferences>(
    () => dependencyModule.sharedPreferences(),
    preResolve: true,
  );
  gh.factory<_i7.AuthApi>(
      () => _i8.FirebaseAuthModuleImpl(gh<_i3.FirebaseAuth>()));
  gh.factory<_i9.SharedPreferencesModule>(() =>
      _i10.SharedPreferencesModuleImpl(
          sharedPreferences: gh<_i6.StreamingSharedPreferences>()));
  gh.factory<_i11.AuthRepo>(() => _i12.AuthRepoImpl(
        firebaseAuthModule: gh<_i7.AuthApi>(),
        sharedPreferencesModule: gh<_i9.SharedPreferencesModule>(),
      ));
  gh.factory<_i13.AuthUseCase>(() => _i14.AuthUseCaseImpl(gh<_i11.AuthRepo>()));
  gh.factory<_i15.InitialVm>(() => _i15.InitialVm(gh<_i13.AuthUseCase>()));
  gh.factory<_i16.LoginVm>(() => _i16.LoginVm(gh<_i13.AuthUseCase>()));
  gh.factory<_i17.MainVm>(() => _i17.MainVm(gh<_i13.AuthUseCase>()));
  return getIt;
}

class _$DependencyModule extends _i18.DependencyModule {}
