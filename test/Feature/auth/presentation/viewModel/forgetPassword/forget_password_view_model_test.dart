import 'package:flower_e_commerce_app/Feature/auth/domain/entities/request/forget_password_request_entity.dart';
import 'package:flower_e_commerce_app/Feature/auth/domain/entities/request/verify_reset_code_request_entity.dart';
import 'package:flower_e_commerce_app/Feature/auth/domain/entities/response/forget_password_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/auth/domain/entities/response/reset_password_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/auth/domain/entities/response/verify_reset_code_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/auth/domain/useCases/forget_password_use_case.dart';
import 'package:flower_e_commerce_app/Feature/auth/domain/useCases/reset_password_use_case.dart';
import 'package:flower_e_commerce_app/Feature/auth/domain/useCases/verify_reset_code_use_case.dart';
import 'package:flower_e_commerce_app/Feature/auth/presentation/viewModel/events/forget_password_intent.dart';
import 'package:flower_e_commerce_app/Feature/auth/presentation/viewModel/states/forget_password_states.dart';
import 'package:flower_e_commerce_app/Feature/auth/presentation/viewModel/viewModel/forget_password_view_model.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:flower_e_commerce_app/core/Errors/failure.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'forget_password_view_model_test.mocks.dart';

@GenerateMocks([
  ForgetPasswordUseCase,
  VerifyResetCodeUseCase,
  ResetPasswordUseCase,
])
void main() {
  late MockForgetPasswordUseCase mockForget;
  late MockVerifyResetCodeUseCase mockVerify;
  late MockResetPasswordUseCase mockReset;
  late ForgetPasswordViewModel vm;

  setUp(() {
    mockForget = MockForgetPasswordUseCase();
    mockVerify = MockVerifyResetCodeUseCase();
    mockReset = MockResetPasswordUseCase();
    vm = ForgetPasswordViewModel(mockForget, mockVerify, mockReset);
  });

  tearDown(() async {
    await vm.close();
  });

  test('initial state', () {
    expect(vm.state, const ForgetPasswordState());
  });

  testWidgets('SendForgetRequestIntent: loading -> success -> verify step', (tester) async {
    when(mockForget.invoke(any)).thenAnswer((_) async =>
        ApiSuccessResult<ForgetPasswordResponseEntity>(
          data: ForgetPasswordResponseEntity(message: 'Email sent', info: ''),
        ));

    await tester.pumpWidget(MaterialApp(home: Form(key: vm.forgetPasswordKey, child: const SizedBox())));
    vm.emailController.text = 'test@example.com';

    final emitted = <ForgetPasswordState>[];
    final sub = vm.stream.listen(emitted.add);

    await vm.doIntent(SendForgetRequestIntent());
    await tester.pump();
    await sub.cancel();

    expect(emitted[0].status, ForgetPasswordStatus.loading);
    expect(emitted[1].status, ForgetPasswordStatus.success);
    expect(emitted[1].step, ForgetPasswordStep.verify);
    expect(emitted[1].email, 'test@example.com');
    verify(mockForget.invoke(argThat(isA<ForgetPasswordRequestEntity>()))).called(1);
  });

  testWidgets('SendForgetRequestIntent: loading -> error', (tester) async {
    when(mockForget.invoke(any)).thenAnswer((_) async =>
        ApiErrorResult<ForgetPasswordResponseEntity>(failure: Failure(errorMessage: 'err')));

    await tester.pumpWidget(MaterialApp(home: Form(key: vm.forgetPasswordKey, child: const SizedBox())));
    vm.emailController.text = 'x@y.com';

    final emitted = <ForgetPasswordState>[];
    final sub = vm.stream.listen(emitted.add);

    await vm.doIntent(SendForgetRequestIntent());
    await tester.pump();
    await sub.cancel();

    expect(emitted[0].status, ForgetPasswordStatus.loading);
    expect(emitted[1].status, ForgetPasswordStatus.error);
    expect(emitted[1].errorMsg, 'err');
  });

  testWidgets('VerifyCodeIntent: loading -> success -> reset step', (tester) async {
    when(mockVerify.invoke(any)).thenAnswer((_) async =>
        ApiSuccessResult<VerifyResetCodeResponseEntity>(
          data: VerifyResetCodeResponseEntity(status: 'ok'),
        ));

    await tester.pumpWidget(MaterialApp(home: Form(key: vm.verifyCodeKey, child: const SizedBox())));
    vm.codeController.text = '123456';

    final emitted = <ForgetPasswordState>[];
    final sub = vm.stream.listen(emitted.add);
    await vm.doIntent(VerifyCodeIntent());
    await tester.pump();
    await sub.cancel();

    expect(emitted[0].status, ForgetPasswordStatus.loading);
    expect(emitted[1].status, ForgetPasswordStatus.success);
    expect(emitted[1].step, ForgetPasswordStep.reset);
    verify(mockVerify.invoke(argThat(isA<VerifyResetCodeRequestEntity>()))).called(1);
  });

  testWidgets('VerifyCodeIntent: loading -> error', (tester) async {
    when(mockVerify.invoke(any)).thenAnswer((_) async =>
        ApiErrorResult<VerifyResetCodeResponseEntity>(failure: Failure(errorMessage: 'bad')));

    await tester.pumpWidget(MaterialApp(home: Form(key: vm.verifyCodeKey, child: const SizedBox())));
    vm.codeController.text = '000000';

    final emitted = <ForgetPasswordState>[];
    final sub = vm.stream.listen(emitted.add);
    await vm.doIntent(VerifyCodeIntent());
    await tester.pump();
    await sub.cancel();

    expect(emitted[0].status, ForgetPasswordStatus.loading);
    expect(emitted[1].status, ForgetPasswordStatus.error);
    expect(emitted[1].errorMsg, 'bad');
  });

  testWidgets('ResendCodeIntent: loading -> success (disables resend)', (tester) async {
    when(mockForget.invoke(any)).thenAnswer((_) async =>
        ApiSuccessResult<ForgetPasswordResponseEntity>(
          data: ForgetPasswordResponseEntity(message: 'Email sent', info: ''),
        ));

    await tester.pumpWidget(MaterialApp(home: Form(key: vm.forgetPasswordKey, child: const SizedBox())));
    vm.emit(vm.state.copyWith(email: 'seed@example.com'));

    final emitted = <ForgetPasswordState>[];
    final sub = vm.stream.listen(emitted.add);
    await vm.doIntent(ResendCodeIntent());
    await tester.pump();
    await sub.cancel();

    expect(emitted[0].status, ForgetPasswordStatus.loading);
    expect(emitted[1].status, ForgetPasswordStatus.success);
    expect(emitted[1].step, ForgetPasswordStep.resend);
    expect(emitted[1].isResendAvailable, isFalse);
  });

  testWidgets('ResendCodeIntent: loading -> error', (tester) async {
    when(mockForget.invoke(any)).thenAnswer((_) async =>
        ApiErrorResult<ForgetPasswordResponseEntity>(failure: Failure(errorMessage: 'network')));

    await tester.pumpWidget(MaterialApp(home: Form(key: vm.forgetPasswordKey, child: const SizedBox())));
    vm.emit(vm.state.copyWith(email: 'seed@example.com'));

    final emitted = <ForgetPasswordState>[];
    final sub = vm.stream.listen(emitted.add);
    await vm.doIntent(ResendCodeIntent());
    await tester.pump();
    await sub.cancel();

    expect(emitted[0].status, ForgetPasswordStatus.loading);
    expect(emitted[1].status, ForgetPasswordStatus.error);
    expect(emitted[1].errorMsg, 'network');
  });

  testWidgets('ResetPasswordIntent: loading -> success', (tester) async {
    when(mockReset.invoke(any)).thenAnswer((_) async =>
        ApiSuccessResult<ResetPasswordResponseEntity>(
          data: ResetPasswordResponseEntity(message: 'ok', token: 't'),
        ));

    await tester.pumpWidget(MaterialApp(home: Form(key: vm.resetPasswordKey, child: const SizedBox())));
    vm.emit(vm.state.copyWith(email: 'test@example.com'));
    vm.newPasswordController.text = '123456';

    final emitted = <ForgetPasswordState>[];
    final sub = vm.stream.listen(emitted.add);
    await vm.doIntent(ResetPasswordIntent());
    await tester.pump();
    await sub.cancel();

    expect(emitted[0].status, ForgetPasswordStatus.loading);
    expect(emitted[1].status, ForgetPasswordStatus.success);
    expect(emitted[1].resetResponse, isNotNull);
  });

  testWidgets('ResetPasswordIntent: loading -> error', (tester) async {
    when(mockReset.invoke(any)).thenAnswer((_) async =>
        ApiErrorResult<ResetPasswordResponseEntity>(failure: Failure(errorMessage: 'server')));

    await tester.pumpWidget(MaterialApp(home: Form(key: vm.resetPasswordKey, child: const SizedBox())));
    vm.emit(vm.state.copyWith(email: 'test@example.com'));
    vm.newPasswordController.text = 'bad';

    final emitted = <ForgetPasswordState>[];
    final sub = vm.stream.listen(emitted.add);
    await vm.doIntent(ResetPasswordIntent());
    await tester.pump();
    await sub.cancel();

    expect(emitted[0].status, ForgetPasswordStatus.loading);
    expect(emitted[1].status, ForgetPasswordStatus.error);
    expect(emitted[1].errorMsg, 'server');
  });

  test('ResendTimerFinishedIntent sets resend available', () async {
    final states = <ForgetPasswordState>[];
    final sub = vm.stream.listen(states.add);
    await vm.doIntent(ResendTimerFinishedIntent());
    await sub.cancel();
    expect(states.single.isResendAvailable, isTrue);
  });
}

