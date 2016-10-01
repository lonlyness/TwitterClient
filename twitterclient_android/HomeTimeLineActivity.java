package com.example.nishimura.twittertakuma;

import android.app.ListActivity;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.view.View;
import android.webkit.CookieManager;
import android.webkit.CookieSyncManager;
import android.widget.Button;
import android.widget.ListView;
import android.widget.Toast;

import com.google.android.gms.appindexing.Action;
import com.google.android.gms.appindexing.AppIndex;
import com.google.android.gms.common.api.GoogleApiClient;
import com.twitter.sdk.android.Twitter;
import com.twitter.sdk.android.core.Callback;
import com.twitter.sdk.android.core.Result;
import com.twitter.sdk.android.core.TwitterApiClient;
import com.twitter.sdk.android.core.TwitterCore;
import com.twitter.sdk.android.core.TwitterException;
import com.twitter.sdk.android.core.models.Tweet;
import com.twitter.sdk.android.core.services.StatusesService;
import com.twitter.sdk.android.tweetui.CompactTweetView;
import com.twitter.sdk.android.tweetui.TweetView;
import com.twitter.sdk.android.tweetui.TweetViewAdapter;
import com.twitter.sdk.android.tweetui.TweetViewFetchAdapter;

import java.util.List;


public class HomeTimeLineActivity extends ListActivity {

    final TweetViewFetchAdapter adapter =
            new TweetViewFetchAdapter<TweetView>(
                    HomeTimeLineActivity.this);


    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);



        setContentView(R.layout.home_time_line);
        setListAdapter(adapter);
        final StatusesService service = Twitter.getInstance().getApiClient().getStatusesService();
        service.homeTimeline(null, null, null, null, null, null, null, new Callback<List<Tweet>>() {
            @Override
            public void success(Result<List<Tweet>> result) {
                adapter.setTweets(result.data);
            }

            @Override
            public void failure(TwitterException error) {
                Toast.makeText(HomeTimeLineActivity.this, "Failed to retrieve timeline",
                        Toast.LENGTH_SHORT).show();
            }
        });

        Button btnLogout = (Button) findViewById(R.id.logout);
        Button btnDisp = (Button)findViewById(R.id.mention);

        btnLogout.setOnClickListener(new View.OnClickListener()
        {
            @Override
            public void onClick(View v) {
            CookieSyncManager.createInstance(HomeTimeLineActivity.this);
            CookieManager cookieManager = CookieManager.getInstance();
            cookieManager.removeSessionCookie();
            Twitter.getSessionManager().clearActiveSession();
            Twitter.logOut();
            Intent intent = new Intent(HomeTimeLineActivity.this, MainActivity.class);
            startActivity(intent);
        }
        });

        btnDisp.setOnClickListener(new View.OnClickListener(){
            public void onClick(View v){
                final Intent intent = new Intent( HomeTimeLineActivity.this, MentionActivity.class);
                startActivity(intent);
                finish();
            }
        });

        Button btnload = (Button) findViewById(R.id.load);

    }
}