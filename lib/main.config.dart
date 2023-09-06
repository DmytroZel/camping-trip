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
    as _i20;

import 'data/api/auth_api/auth_api.dart' as _i22;
import 'data/api/auth_api/auth_api_impl.dart' as _i23;
import 'data/api/dish_item_api/dish_item_api.dart' as _i24;
import 'data/api/dish_item_api/dish_item_api_impl.dart' as _i25;
import 'data/api/firebase_trip_api/firebase_trip_api.dart' as _i6;
import 'data/api/firebase_trip_api/firebase_trip_api_impl.dart' as _i7;
import 'data/api/ingredient_api/ingredient_api.dart' as _i10;
import 'data/api/ingredient_api/ingredient_api_impl.dart' as _i11;
import 'data/api/invite_api/invite_api.dart' as _i16;
import 'data/api/invite_api/invite_api_impl.dart' as _i17;
import 'data/api/user_api/firebase_user_api.dart' as _i8;
import 'data/api/user_api/firebase_user_api_impl.dart' as _i9;
import 'data/di/dependency_module.dart' as _i54;
import 'data/repository/auth_repository/auth_repo.dart' as _i36;
import 'data/repository/auth_repository/auth_repo_impl.dart' as _i37;
import 'data/repository/dish_repository/dish_repository.dart' as _i26;
import 'data/repository/dish_repository/dish_repository_impl.dart' as _i27;
import 'data/repository/ingredient_repository/ingredient_repository.dart'
    as _i12;
import 'data/repository/ingredient_repository/ingredient_repository_impl.dart'
    as _i13;
import 'data/repository/invite_repo/invite_repo.dart' as _i18;
import 'data/repository/invite_repo/invite_repo_impl.dart' as _i19;
import 'data/repository/trip_repo/trip_repo.dart' as _i43;
import 'data/repository/trip_repo/trip_repo_impl.dart' as _i44;
import 'data/repository/user_repo/user_repo.dart' as _i32;
import 'data/repository/user_repo/user_repo_impl.dart' as _i33;
import 'data/shared_preferences/shared_preferences_module.dart' as _i30;
import 'data/shared_preferences/shared_preferences_module_impl.dart' as _i31;
import 'data/use_cases/auth_use_case/auth_use_case.dart' as _i38;
import 'data/use_cases/auth_use_case/auth_use_case_impl.dart' as _i39;
import 'data/use_cases/dish_use_case/dish_use_case.dart' as _i28;
import 'data/use_cases/dish_use_case/dish_use_case_impl.dart' as _i29;
import 'data/use_cases/ingredients_use_case/ingredient_use_case.dart' as _i14;
import 'data/use_cases/ingredients_use_case/ingredient_use_case_impl.dart'
    as _i15;
import 'data/use_cases/invite_user_use_case/invite_user_use_case.dart' as _i49;
import 'data/use_cases/invite_user_use_case/invite_user_use_case_impl.dart'
    as _i50;
import 'data/use_cases/trip_use_case/trip_use_case.dart' as _i45;
import 'data/use_cases/trip_use_case/trip_use_case_impl.dart' as _i46;
import 'data/use_cases/user_use_case/user_use_case.dart' as _i34;
import 'data/use_cases/user_use_case/user_use_case_impl.dart' as _i35;
import 'feature/%20ingredients/add_ingredients/add_ingredients_vm.dart' as _i21;
import 'feature/account/account_vm.dart' as _i53;
import 'feature/create_trip/create_trip_vm.dart' as _i48;
import 'feature/initial/initila_vm.dart' as _i40;
import 'feature/login/login_vm.dart' as _i41;
import 'feature/login/register/register_vm.dart' as _i42;
import 'feature/main/main_vm.dart' as _i51;
import 'feature/trip/add_dish_model_botom_sheet/add_dish_vm.dart' as _i47;
import 'feature/trip/trip_vm.dart' as _i52;

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
  gh.factory<_i10.IngredientApi>(
      () => _i11.IngredientApiImpl(gh<_i4.FirebaseFirestore>()));
  gh.factory<_i12.IngredientRepository>(
      () => _i13.IngredientRepositoryImpl(gh<_i10.IngredientApi>()));
  gh.factory<_i14.IngredientUseCase>(() => _i15.IngredientUseCaseImpl());
  gh.factory<_i16.InviteApi>(
      () => _i17.InviteApiImpl(gh<_i4.FirebaseFirestore>()));
  gh.factory<_i18.InviteRepo>(() => _i19.InviteRepoImpl(
        gh<_i6.FirebaseTripApi>(),
        gh<_i8.FirebaseUserAPi>(),
        gh<_i16.InviteApi>(),
      ));
  await gh.factoryAsync<_i20.StreamingSharedPreferences>(
    () => dependencyModule.sharedPreferences(),
    preResolve: true,
  );
  gh.factory<_i21.AddIngredientsVM>(
      () => _i21.AddIngredientsVM(gh<_i14.IngredientUseCase>()));
  gh.factory<_i22.AuthApi>(
      () => _i23.FirebaseAuthModuleImpl(gh<_i3.FirebaseAuth>()));
  gh.factory<_i24.DishApi>(
      () => _i25.DishItemApiImpl(gh<_i4.FirebaseFirestore>()));
  gh.factory<_i26.DishRepository>(
      () => _i27.DishRepositoryImpl(gh<_i24.DishApi>()));
  gh.factory<_i28.DishUseCase>(
      () => _i29.DishUseCaseImpl(gh<_i26.DishRepository>()));
  gh.factory<_i30.SharedPreferencesModule>(() =>
      _i31.SharedPreferencesModuleImpl(
          sharedPreferences: gh<_i20.StreamingSharedPreferences>()));
  gh.factory<_i32.UserRepo>(() => _i33.UserRepoImpl(
        gh<_i8.FirebaseUserAPi>(),
        gh<_i30.SharedPreferencesModule>(),
      ));
  gh.factory<_i34.UserUseCase>(() => _i35.UserUseCaseImpl(gh<_i32.UserRepo>()));
  gh.factory<_i36.AuthRepo>(() => _i37.AuthRepoImpl(
        gh<_i8.FirebaseUserAPi>(),
        firebaseAuthModule: gh<_i22.AuthApi>(),
        sharedPreferencesModule: gh<_i30.SharedPreferencesModule>(),
      ));
  gh.factory<_i38.AuthUseCase>(() => _i39.AuthUseCaseImpl(gh<_i36.AuthRepo>()));
  gh.factory<_i40.InitialVm>(() => _i40.InitialVm(gh<_i38.AuthUseCase>()));
  gh.factory<_i41.LoginVm>(() => _i41.LoginVm(gh<_i38.AuthUseCase>()));
  gh.factory<_i42.RegisterVM>(() => _i42.RegisterVM(gh<_i34.UserUseCase>()));
  gh.factory<_i43.TripRepo>(() => _i44.TripRepoImpl(
        gh<_i6.FirebaseTripApi>(),
        gh<_i36.AuthRepo>(),
      ));
  gh.factory<_i45.TripUseCase>(() => _i46.TripUseCaseImpl(gh<_i43.TripRepo>()));
  gh.factory<_i47.AddDishVM>(() => _i47.AddDishVM(
        gh<_i28.DishUseCase>(),
        gh<_i45.TripUseCase>(),
      ));
  gh.factory<_i48.CreateTripVm>(() => _i48.CreateTripVm(
        gh<_i45.TripUseCase>(),
        gh<_i34.UserUseCase>(),
      ));
  gh.factory<_i49.InviteUserUseCase>(() => _i50.InviteUserUseCaseImpl(
        gh<_i18.InviteRepo>(),
        gh<_i43.TripRepo>(),
      ));
  gh.factory<_i51.MainVm>(() => _i51.MainVm(
        gh<_i38.AuthUseCase>(),
        gh<_i34.UserUseCase>(),
        gh<_i45.TripUseCase>(),
      ));
  gh.factoryParam<_i52.TripVM, String, dynamic>((
    id,
    _,
  ) =>
      _i52.TripVM(
        gh<_i45.TripUseCase>(),
        id,
        gh<_i34.UserUseCase>(),
        gh<_i49.InviteUserUseCase>(),
      ));
  gh.factory<_i53.AccountVM>(() => _i53.AccountVM(
        gh<_i34.UserUseCase>(),
        gh<_i49.InviteUserUseCase>(),
      ));
  return getIt;
}

class _$DependencyModule extends _i54.DependencyModule {}
