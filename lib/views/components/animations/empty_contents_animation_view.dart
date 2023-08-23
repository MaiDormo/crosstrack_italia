import 'package:crosstrack_italia/views/components/animations/lottie_animation_view.dart';
import 'package:crosstrack_italia/views/components/animations/models/lottie_animation.dart';

class EmptyContentsAnimationView extends LottieAnimationView {
  const EmptyContentsAnimationView({super.key})
      : super(
          animation: LottieAnimation.empty,
        );
}
