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
    as _i10;

import 'data/api/auth_api/auth_api.dart' as _i15;
import 'data/api/auth_api/auth_api_impl.dart' as _i16;
import 'data/api/firebase_trip_model/firebase_trip_api.dart' as _i6;
import 'data/api/firebase_trip_model/firebase_trip_api_impl.dart' as _i7;
import 'data/api/user_api/firebase_user_api.dart' as _i8;
import 'data/api/user_api/firebase_user_api_impl.dart' as _i9;
import 'data/di/dependency_module.dart' as _i30;
import 'data/repository/auth_repository/auth_repo.dart' as _i23;
import 'data/repository/auth_repository/auth_repo_impl.dart' as _i24;
import 'data/repository/trip_repo/trip_repo.dart' as _i11;
import 'data/repository/trip_repo/trip_repo_impl.dart' as _i12;
import 'data/repository/user_repo/user_repo.dart' as _i19;
import 'data/repository/user_repo/user_repo_impl.dart' as _i20;
import 'data/shared_preferences/shared_preferences_module.dart' as _i17;
import 'data/shared_preferences/shared_preferences_module_impl.dart' as _i18;
import 'data/use_cases/auth_use_case/auth_use_case.dart' as _i25;
import 'data/use_cases/auth_use_case/auth_use_case_impl.dart' as _i26;
import 'data/use_cases/trip_use_case/trip_use_case.dart' as _i13;
import 'data/use_cases/trip_use_case/trip_use_case_impl.dart' as _i14;
import 'data/use_cases/user_use_case/user_use_case.dart' as _i21;
import 'data/use_cases/user_use_case/user_use_case_impl.dart' as _i22;
import 'feature/initial/initila_vm.dart' as _i27;
import 'feature/login/login_vm.dart' as _i28;
import 'feature/main/main_vm.dart' as _i29;

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
  gh.factory<_i6.FirebaseTripApi>(
      () => _i7.FirebaseTripApiImpl(gh<_i4.FirebaseFirestore>()));
  gh.factory<_i8.FirebaseUserAPi>(
      () => _i9.FirebaseUserApiImpl(gh<_i4.FirebaseFirestore>()));
  await gh.factoryAsync<_i10.StreamingSharedPreferences>(
    () => dependencyModule.sharedPreferences(),
    preResolve: true,
  );
  gh.factory<_i11.TripRepo>(() => _i12.TripRepoImpl(gh<_i6.FirebaseTripApi>()));
  gh.factory<_i13.TripUseCase>(() => _i14.TripUseCaseImpl(gh<_i11.TripRepo>()));
  gh.factory<_i15.AuthApi>(
      () => _i16.FirebaseAuthModuleImpl(gh<_i3.FirebaseAuth>()));
  gh.factory<_i17.SharedPreferencesModule>(() =>
      _i18.SharedPreferencesModuleImpl(
          sharedPreferences: gh<_i10.StreamingSharedPreferences>()));
  gh.factory<_i19.UserRepo>(() => _i20.UserRepoImpl(
        gh<_i8.FirebaseUserAPi>(),
        gh<_i17.SharedPreferencesModule>(),
      ));
  gh.factory<_i21.UserUseCase>(() => _i22.UserUseCaseImpl(gh<_i19.UserRepo>()));
  gh.factory<_i23.AuthRepo>(() => _i24.AuthRepoImpl(
        gh<_i8.FirebaseUserAPi>(),
        firebaseAuthModule: gh<_i15.AuthApi>(),
        sharedPreferencesModule: gh<_i17.SharedPreferencesModule>(),
      ));
  gh.factory<_i25.AuthUseCase>(() => _i26.AuthUseCaseImpl(gh<_i23.AuthRepo>()));
  gh.factory<_i27.InitialVm>(() => _i27.InitialVm(gh<_i25.AuthUseCase>()));
  gh.factory<_i28.LoginVm>(() => _i28.LoginVm(gh<_i25.AuthUseCase>()));
  gh.factory<_i29.MainVm>(() => _i29.MainVm(
        gh<_i25.AuthUseCase>(),
        gh<_i21.UserUseCase>(),
      ));
  return getIt;
}

class _$DependencyModule extends _i30.DependencyModule {}
