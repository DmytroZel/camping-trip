import 'package:camp_trip/data/repository/trip_repo/trip_repo.dart';
import 'package:camp_trip/data/repository/user_repo/user_repo.dart';
import 'package:camp_trip/data/use_cases/trip_use_case/trip_use_case.dart';
import 'package:camp_trip/domain/model/model/dish_model.dart';
import 'package:camp_trip/domain/model/repository/trip_model_repo.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/model/model/trip_model.dart';
import '../../../domain/model/repository/dish_model_repo.dart';

@Injectable(as: TripUseCase)
class TripUseCaseImpl extends TripUseCase {
  final TripRepo tripRepo;
  final UserRepo userRepo;

  TripUseCaseImpl(this.tripRepo, this.userRepo);

  @override
  Future<void> addOrUpdate(TripModel tripModel) async {
    final isNeedToAddAdmin = tripModel.members.isEmpty;
    if (isNeedToAddAdmin) {
      tripModel = tripModel.copyWith(members: [tripModel.organizer]);
    }
    await tripRepo.addOrUpdate(TripModelRepo.fromModel(tripModel));
    final user = await userRepo.getUser(tripModel.organizer);
    await tripRepo.addOrUpdateMember(
        MemberModel(
            role: MemberModel.admin,
            userId: user.id,
            userName: user.userName),
        tripModel.id);
  }

  @override
  Future<void> deleteTrip(String tripId) {
    return tripRepo.deleteTrip(tripId);
  }

  @override
  Stream<List<TripModel>> getTrips() {
    return tripRepo
        .getTrips()
        .map((event) => event.map((e) => TripModel.fromRepo(e)).toList());
  }

  @override
  Stream<TripModel> getTrip(String id) {
    return tripRepo.getTrip(id).map((event) => TripModel.fromRepo(event));
  }

  @override
  Future<void> addOrUpdateDishItem(DishModel dishItemModel, String tripId) {
    return tripRepo.addOrUpdateDishItem(
        DishModelRepo.fromModel(dishItemModel), tripId);
  }

  @override
  Future<void> deleteDishItem(String dishItemId, String tripId) {
    return tripRepo.deleteDishItem(dishItemId, tripId);
  }

  @override
  Stream<List<DishModel>> getDishItems(String tripId) {
    return tripRepo
        .getDishItems(tripId)
        .map((event) => event.map((e) => DishModel.fromRepo(e)).toList());
  }

  @override
  Stream<List<MemberModel>> getMember(String tripId) {
    return tripRepo
        .getMember(tripId)
        .map((event) => event.map((e) => MemberModel.fromRepo(e)).toList());
  }

  @override
  Future<void> deleteMember(String member, TripModel trip) async {
    trip.members.remove(member);
    await tripRepo.addOrUpdate(TripModelRepo.fromModel(trip));
    return tripRepo.deleteMember(member, trip.id);
  }
}
