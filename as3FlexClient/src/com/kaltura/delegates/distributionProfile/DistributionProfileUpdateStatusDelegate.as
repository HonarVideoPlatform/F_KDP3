package com.kaltura.delegates.distributionProfile
{
	import com.kaltura.config.KalturaConfig;
	import com.kaltura.net.KalturaCall;
	import com.kaltura.delegates.WebDelegateBase;
	import flash.utils.getDefinitionByName;

	public class DistributionProfileUpdateStatusDelegate extends WebDelegateBase
	{
		public function DistributionProfileUpdateStatusDelegate(call:KalturaCall, config:KalturaConfig)
		{
			super(call, config);
		}

	}
}
