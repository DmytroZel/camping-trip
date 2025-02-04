// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i4;
import 'package:firebase_auth/firebase_auth.dart' as _i3;
import 'package:firebase_storage/firebase_storage.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart'
    as _i22;

import 'data/api/auth_api/auth_api.dart' as _i24;
import 'data/api/auth_api/auth_api_impl.dart' as _i25;
import 'data/api/dish_item_api/dish_item_api.dart' as _i26;
import 'data/api/dish_item_api/dish_item_api_impl.dart' as _i27;
import 'data/api/firebase_trip_api/firebase_trip_api.dart' as _i8;
import 'data/api/firebase_trip_api/firebase_trip_api_impl.dart' as _i9;
import 'data/api/ingredient_api/ingredient_api.dart' as _i12;
import 'data/api/ingredient_api/ingredient_api_impl.dart' as _i13;
import 'data/api/invite_api/invite_api.dart' as _i18;
import 'data/api/invite_api/invite_api_impl.dart' as _i19;
import 'data/api/user_api/firebase_user_api.dart' as _i10;
import 'data/api/user_api/firebase_user_api_impl.dart' as _i11;
import 'data/di/dependency_module.dart' as _i61;
import 'data/firebase_storage/firebase_storage_module.dart' as _i6;
import 'data/firebase_storage/firebase_storage_module_impl.dart' as _i7;
import 'data/repository/auth_repository/auth_repo.dart' as _i39;
import 'data/repository/auth_repository/auth_repo_impl.dart' as _i40;
import 'data/repository/dish_repository/dish_repository.dart' as _i28;
import 'data/repository/dish_repository/dish_repository_impl.dart' as _i29;
import 'data/repository/ingredient_repository/ingredient_repository.dart'
    as _i14;
import 'data/repository/ingredient_repository/ingredient_repository_impl.dart'
    as _i15;
import 'data/repository/invite_repo/invite_repo.dart' as _i20;
import 'data/repository/invite_repo/invite_repo_impl.dart' as _i21;
import 'data/repository/trip_repo/trip_repo.dart' as _i46;
import 'data/repository/trip_repo/trip_repo_impl.dart' as _i47;
import 'data/repository/user_repo/user_repo.dart' as _i34;
import 'data/repository/user_repo/user_repo_impl.dart' as _i35;
import 'data/shared_preferences/shared_preferences_module.dart' as _i32;
import 'data/shared_preferences/shared_preferences_module_impl.dart' as _i33;
import 'data/use_cases/auth_use_case/auth_use_case.dart' as _i41;
import 'data/use_cases/auth_use_case/auth_use_case_impl.dart' as _i42;
import 'data/use_cases/dish_use_case/dish_use_case.dart' as _i30;
import 'data/use_cases/dish_use_case/dish_use_case_impl.dart' as _i31;
import 'data/use_cases/ingredients_use_case/ingredient_use_case.dart' as _i16;
import 'data/use_cases/ingredients_use_case/ingredient_use_case_impl.dart'
    as _i17;
import 'data/use_cases/invite_user_use_case/invite_user_use_case.dart' as _i54;
import 'data/use_cases/invite_user_use_case/invite_user_use_case_impl.dart'
    as _i55;
import 'data/use_cases/trip_use_case/trip_use_case.dart' as _i48;
import 'data/use_cases/trip_use_case/trip_use_case_impl.dart' as _i49;
import 'data/use_cases/user_use_case/user_use_case.dart' as _i36;
import 'data/use_cases/user_use_case/user_use_case_impl.dart' as _i37;
import 'feature/account/account_vm.dart' as _i60;
import 'feature/create_trip/create_trip_vm.dart' as _i52;
import 'feature/ingredients/add_ingredients/add_ingredients_vm.dart' as _i23;
import 'feature/initial/initila_vm.dart' as _i43;
import 'feature/login/login_vm.dart' as _i44;
import 'feature/login/register/register_vm.dart' as _i45;
import 'feature/main/main_vm.dart' as _i56;
import 'feature/trip/add_dish_model_bottom_sheet/add_dish_vm.dart' as _i51;
import 'feature/trip/add_dish_model_bottom_sheet/widget/add_new_dish/add_new_dish_vm.dart'
    as _i38;
import 'feature/trip/pages/eq_page/eq_vm.dart' as _i53;
import 'feature/trip/pages/members_page/members_vm.dart' as _i57;
import 'feature/trip/settings/trip_settings_vm.dart' as _i58;
import 'feature/trip/trip_vm.dart' as _i59;
import 'feature/user_list/user_list_vm.dart' as _i50;

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
  gh.factory<_i6.FirebaseStorageModule>(() => _i7.FirebaseStorageModuleImpl(
      firebaseStorage: gh<_i5.FirebaseStorage>()));
  gh.factory<_i8.FirebaseTripApi>(
      () => _i9.FirebaseTripApiImpl(gh<_i4.FirebaseFirestore>()));
  gh.factory<_i10.FirebaseUserAPi>(
      () => _i11.FirebaseUserApiImpl(gh<_i4.FirebaseFirestore>()));
  gh.factory<_i12.IngredientApi>(
      () => _i13.IngredientApiImpl(gh<_i4.FirebaseFirestore>()));
  gh.factory<_i14.IngredientRepository>(
      () => _i15.IngredientRepositoryImpl(gh<_i12.IngredientApi>()));
  gh.factory<_i16.IngredientUseCase>(
      () => _i17.IngredientUseCaseImpl(gh<_i14.IngredientRepository>()));
  gh.factory<_i18.InviteApi>(
      () => _i19.InviteApiImpl(gh<_i4.FirebaseFirestore>()));
  gh.factory<_i20.InviteRepo>(() => _i21.InviteRepoImpl(
        gh<_i8.FirebaseTripApi>(),
        gh<_i10.FirebaseUserAPi>(),
        gh<_i18.InviteApi>(),
      ));
  await gh.factoryAsync<_i22.StreamingSharedPreferences>(
    () => dependencyModule.sharedPreferences(),
    preResolve: true,
  );
  gh.factory<_i23.AddIngredientsVM>(
      () => _i23.AddIngredientsVM(gh<_i16.IngredientUseCase>()));
  gh.factory<_i24.AuthApi>(
      () => _i25.FirebaseAuthModuleImpl(gh<_i3.FirebaseAuth>()));
  gh.factory<_i26.DishApi>(
      () => _i27.DishItemApiImpl(gh<_i4.FirebaseFirestore>()));
  gh.factory<_i28.DishRepository>(
      () => _i29.DishRepositoryImpl(gh<_i26.DishApi>()));
  gh.factory<_i30.DishUseCase>(
      () => _i31.DishUseCaseImpl(gh<_i28.DishRepository>()));
  gh.factory<_i32.SharedPreferencesModule>(() =>
      _i33.SharedPreferencesModuleImpl(
          sharedPreferences: gh<_i22.StreamingSharedPreferences>()));
  gh.factory<_i34.UserRepo>(() => _i35.UserRepoImpl(
        gh<_i10.FirebaseUserAPi>(),
        gh<_i32.SharedPreferencesModule>(),
        gh<_i6.FirebaseStorageModule>(),
      ));
  gh.factory<_i36.UserUseCase>(() => _i37.UserUseCaseImpl(gh<_i34.UserRepo>()));
  gh.factory<_i38.AddNewDishVM>(() => _i38.AddNewDishVM(
        gh<_i30.DishUseCase>(),
        gh<_i16.IngredientUseCase>(),
      ));
  gh.factory<_i39.AuthRepo>(() => _i40.AuthRepoImpl(
        gh<_i10.FirebaseUserAPi>(),
        firebaseAuthModule: gh<_i24.AuthApi>(),
        sharedPreferencesModule: gh<_i32.SharedPreferencesModule>(),
      ));
  gh.factory<_i41.AuthUseCase>(() => _i42.AuthUseCaseImpl(gh<_i39.AuthRepo>()));
  gh.factory<_i43.InitialVm>(() => _i43.InitialVm(gh<_i41.AuthUseCase>()));
  gh.factory<_i44.LoginVm>(() => _i44.LoginVm(gh<_i41.AuthUseCase>()));
  gh.factory<_i45.RegisterVM>(() => _i45.RegisterVM(gh<_i36.UserUseCase>()));
  gh.factory<_i46.TripRepo>(() => _i47.TripRepoImpl(
        gh<_i8.FirebaseTripApi>(),
        gh<_i39.AuthRepo>(),
      ));
  gh.factory<_i48.TripUseCase>(() => _i49.TripUseCaseImpl(
        gh<_i46.TripRepo>(),
        gh<_i34.UserRepo>(),
      ));
  gh.factory<_i50.UserListVm>(() => _i50.UserListVm(gh<_i36.UserUseCase>()));
  gh.factory<_i51.AddDishVM>(() => _i51.AddDishVM(
        gh<_i30.DishUseCase>(),
        gh<_i48.TripUseCase>(),
      ));
  gh.factory<_i52.CreateTripVm>(() => _i52.CreateTripVm(
        gh<_i48.TripUseCase>(),
        gh<_i36.UserUseCase>(),
      ));
  gh.factory<_i53.EquipmentVM>(() => _i53.EquipmentVM(gh<_i48.TripUseCase>()));
  gh.factory<_i54.InviteUserUseCase>(() => _i55.InviteUserUseCaseImpl(
        gh<_i20.InviteRepo>(),
        gh<_i46.TripRepo>(),
      ));
  gh.factory<_i56.MainVm>(() => _i56.MainVm(
        gh<_i41.AuthUseCase>(),
        gh<_i36.UserUseCase>(),
        gh<_i48.TripUseCase>(),
      ));
  gh.factory<_i57.MembersVM>(() => _i57.MembersVM(gh<_i48.TripUseCase>()));
  gh.factoryParam<_i58.TripSettingsVM, String, dynamic>((
    tripId,
    _,
  ) =>
      _i58.TripSettingsVM(
        gh<_i48.TripUseCase>(),
        gh<_i54.InviteUserUseCase>(),
        gh<_i36.UserUseCase>(),
        tripId: tripId,
      ));
  gh.factoryParam<_i59.TripVM, String, dynamic>((
    id,
    _,
  ) =>
      _i59.TripVM(
        gh<_i48.TripUseCase>(),
        id,
        gh<_i36.UserUseCase>(),
        gh<_i54.InviteUserUseCase>(),
      ));
  gh.factory<_i60.AccountVM>(() => _i60.AccountVM(
        gh<_i36.UserUseCase>(),
        gh<_i54.InviteUserUseCase>(),
      ));
  return getIt;
}

class _$DependencyModule extends _i61.DependencyModule {}
