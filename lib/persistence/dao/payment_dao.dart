import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:movie_booking_app/data.vos/vos/banner_image_vo.dart';
import 'package:movie_booking_app/data.vos/vos/payment_vo.dart';
import 'package:movie_booking_app/network/responses/sign_in_with_phone_response.dart';
import 'package:movie_booking_app/persistence/hive_constants.dart';

import '../../data.vos/vos/city_vo.dart';
import '../../data.vos/vos/user_info_vo.dart';

class PaymentDao{
  static final PaymentDao _singleton = PaymentDao._internal();

  factory PaymentDao(){
    return _singleton;
  }

  PaymentDao._internal();

  void saveAllPayments(List<PaymentVO>paymentList) async{
    Map<int,PaymentVO> paymentMap = Map.fromIterable(paymentList,key: (payment)=>payment.id,value:(payment)=>payment);
    await getPaymentBox().putAll(paymentMap);
  }

  List<PaymentVO> getAllPayments(){
    return getPaymentBox().values.toList();
  }

  ///Reactive Programming
  Stream<void> getAllPaymentsEvent(){
    return getPaymentBox().watch();
}

  Stream<List<PaymentVO>> getAllPaymentsStream(){
    return Stream.value(getAllPayments());
  }

  Box<PaymentVO> getPaymentBox(){
    return Hive.box<PaymentVO>(BOX_NAME_PAYMENT_VO);
  }
}