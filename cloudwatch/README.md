cloudwatch Cookbook
===================

Usage
-----
#### cloudwatch::default

Create Alarm.

* CPUUtilization > 90
* MemoryUtilization > 90
* DiskSpaceUtilization > 90

```json
{
  "cloudwatch": {
    "name": "your-app-name",
    "ok_actions": [
      "arn:aws:sns:ap-northeast-1:580183201712:alert-your-app-name"
    ],
    "alarm_actions": [
      "arn:aws:sns:ap-northeast-1:580183201712:alert-your-app-name"
    ],
    "insufficient_data_actions": [
      "arn:aws:sns:ap-northeast-1:580183201712:alert-your-app-name"
    ]
  }
}
```

#### cloudwatch::delete

Delete Alarm.

Contributing
------------
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
* Author: danny (danny.dev8@gmail.com)
* License: MIT
