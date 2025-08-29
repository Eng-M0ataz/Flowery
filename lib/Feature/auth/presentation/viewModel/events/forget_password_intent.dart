sealed class ForgetPasswordIntent {}

class SendForgetRequestIntent extends ForgetPasswordIntent {}

class VerifyCodeIntent extends ForgetPasswordIntent {}

class ResendCodeIntent extends ForgetPasswordIntent {}

class ResetPasswordIntent extends ForgetPasswordIntent {}

class ResendTimerFinishedIntent extends ForgetPasswordIntent {}
