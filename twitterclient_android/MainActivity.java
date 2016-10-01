package com.example.nishimura.twittertakuma;

import android.content.Intent;
import android.support.v7.app.ActionBar;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;

import com.crashlytics.android.Crashlytics;
import com.twitter.sdk.android.Twitter;
import com.twitter.sdk.android.core.Callback;
import com.twitter.sdk.android.core.Result;
import com.twitter.sdk.android.core.TwitterAuthConfig;
import com.twitter.sdk.android.core.TwitterException;
import com.twitter.sdk.android.core.TwitterSession;
import com.twitter.sdk.android.core.identity.TwitterLoginButton;

import io.fabric.sdk.android.Fabric;

public class MainActivity extends AppCompatActivity {

    // Note: Your consumer key and secret should be obfuscated in your source code before shipping.
    private static final String TWITTER_KEY = "Ios1ic5Nf41xAfdgRTOyP2rTs";
    private static final String TWITTER_SECRET = "aBL0Al0RpMqq092gh3ww9mrmifVMoPjDyun1kUihGtJ4FPIIwU";
    private TwitterLoginButton loginButton;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        TwitterAuthConfig authConfig = new TwitterAuthConfig(TWITTER_KEY, TWITTER_SECRET);
        Fabric.with(this, new Twitter(authConfig));
        setContentView(R.layout.activity_main);

        loginButton = (TwitterLoginButton) findViewById(R.id.login_button);
        loginButton.setCallback(new Callback<TwitterSession>() {
            @Override
            public void success(Result<TwitterSession> result) {
                //成功時の処理をかく
                //intentを作成し、それをstartActivityにわたすことで画面を変更する。
                // Do something with result, which provides a
                // TwitterSession for making API calls
               final Intent intent = new Intent(MainActivity.this, HomeTimeLineActivity.class);
                startActivity(intent);
            }
            @Override
            public void failure(TwitterException exception) {
                // Do something on failure

            }
        });
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        //activity の終了結果をログインボタンに渡す。
        loginButton.onActivityResult(requestCode, resultCode,
                data);
    }


}
