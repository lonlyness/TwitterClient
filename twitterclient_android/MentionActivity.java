package com.example.nishimura.twittertakuma;

import android.app.ListActivity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.webkit.CookieManager;
import android.webkit.CookieSyncManager;
import android.widget.Button;
import android.widget.Toast;

import com.twitter.sdk.android.Twitter;
import com.twitter.sdk.android.core.Callback;
import com.twitter.sdk.android.core.Result;
import com.twitter.sdk.android.core.TwitterException;
import com.twitter.sdk.android.core.models.Tweet;
import com.twitter.sdk.android.core.services.StatusesService;
import com.twitter.sdk.android.tweetui.CompactTweetView;
import com.twitter.sdk.android.tweetui.LoadCallback;
import com.twitter.sdk.android.tweetui.TweetTimelineListAdapter;
import com.twitter.sdk.android.tweetui.TweetView;
import com.twitter.sdk.android.tweetui.TweetViewFetchAdapter;
import com.twitter.sdk.android.tweetui.UserTimeline;

import java.util.Arrays;
import java.util.List;


public class MentionActivity extends ListActivity {

    final TweetViewFetchAdapter adapter =
            new TweetViewFetchAdapter<TweetView>(
                    MentionActivity.this);


    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.mention);
        setListAdapter(adapter);
        final StatusesService service = Twitter.getInstance().getApiClient().getStatusesService();
        service.mentionsTimeline(null, null, null, null, null, null, new Callback<List<Tweet>>() {
            @Override
            public void success(Result<List<Tweet>> result) {
                adapter.setTweets(result.data);
            }

            @Override
            public void failure(TwitterException error) {

            }
        });


        Button btnDisp = (Button)findViewById(R.id.hometimeline);
        btnDisp.setOnClickListener(new View.OnClickListener(){
            public void onClick(View v){
                final Intent intent = new Intent(MentionActivity.this, HomeTimeLineActivity.class);
                startActivity(intent);
                finish();
            }
        });

        Button btnLogout = (Button) findViewById(R.id.logout);
        btnLogout.setOnClickListener(new View.OnClickListener()
        {
            @Override
            public void onClick(View v) {
                CookieSyncManager.createInstance(MentionActivity.this);
                CookieManager cookieManager = CookieManager.getInstance();
                cookieManager.removeSessionCookie();
                Twitter.getSessionManager().clearActiveSession();
                Twitter.logOut();
                Intent intent = new Intent(MentionActivity.this, MainActivity.class);
                startActivity(intent);
            }
        });
    }


}