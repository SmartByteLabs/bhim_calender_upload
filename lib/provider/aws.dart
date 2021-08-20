import 'dart:io';

import 'package:aws_s3/aws_s3.dart';

class AwsHelper {
  String awsFolderPath = "";
  String bucketName = "";
  Regions region = Regions.AP_EAST_1;

  Future<String> upload(File f) async {
    AwsS3 awsS3 = AwsS3(
        awsFolderPath: awsFolderPath,
        file: f,
        fileNameWithExt: f.path.split('/').last,
        // poolId: poolId,
        region: region,
        bucketName: bucketName);

    return awsS3.uploadFile;
  }
}
