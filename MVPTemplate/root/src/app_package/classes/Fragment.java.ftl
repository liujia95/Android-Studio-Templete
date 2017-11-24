package ${packageName}.view;

import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.support.v7.widget.Toolbar;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;
import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.Unbinder;
<#if hasStateManager>import cn.itsite.statemanager.StateManager;</#if>
<#if hasPtrFrameLayout>import ${packageName}.PtrHTFrameLayout;</#if>
<#if hasRecyclerView>import android.support.v7.widget.RecyclerView;</#if>

public class ${className}Fragment extends BaseFragment<${className}Contract.Presenter> implements ${className}Contract.View {

    public static final String TAG = ${className}Fragment.class.getSimpleName();

    @BindView(R.id.toolbar_title)
    TextView toolbarTitle;
    @BindView(R.id.toolbar)
    Toolbar toolbar;
<#if hasPtrFrameLayout>
    @BindView(R.id.ptrFrameLayout)
    PtrHTFrameLayout ptrFrameLayout;
</#if>
<#if hasRecyclerView>
	@BindView(R.id.recyclerView)
	RecyclerView recyclerView;

	${className}RVAdapter adapter;
</#if>

    private Unbinder unbinder;
    private Params params = Params.getInstance();
	<#if hasStateManager>StateManager mStateManager;</#if>
	
	
    public static ${className}Fragment newInstance() {
        return new ${className}Fragment();
    }

    @NonNull
    @Override
    protected ${className}Contract.Presenter createPresenter() {
        return new ${className}Presenter(this);
    }

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout., container, false);
        unbinder = ButterKnife.bind(this, view);
        return attachToSwipeBack(view);
    }

    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        initToolbar();
        initData();
		<#if hasStateManager>initStateManager();</#if>
        initListener();
		<#if hasPtrFrameLayout>initPtrFrameLayout(ptrFrameLayout, recyclerView);</#if>
    }

    @Override
    public void onRefresh() {
        params.page = 1;
        params.pageSize = Constants.PAGE_SIZE;
    }

    private void initToolbar() {
        initStateBar(toolbar);
        toolbarTitle.setText("");
        toolbar.setNavigationIcon(R.drawable.ic_chevron_left_white_24dp);
        toolbar.setNavigationOnClickListener(v -> _mActivity.onBackPressedSupport());
    }

<#if hasStateManager>
	private void initStateManager() {
        mStateManager = StateManager.builder(_mActivity)
                .setContent(recyclerView)
                .setEmptyView(R.layout.state_empty)
                .setEmptyText("暂无历史记录！")
                .setErrorOnClickListener(v -> ptrFrameLayout.autoRefresh())
                .setEmptyOnClickListener(v -> ptrFrameLayout.autoRefresh())
                .setConvertListener((holder, stateLayout) ->
                        holder.setOnClickListener(R.id.bt_empty_state,
                                v -> ptrFrameLayout.autoRefresh())
                                .setText(R.id.bt_empty_state, "点击刷新"))
                .build();
    }
</#if>
	
    private void initData() {
<#if hasRecyclerView>
		//初始化RecyclerView
		adapter = new ${className}RVAdapter();
		recyclerView.setLayoutManager(new LinearLayoutManager(_mActivity));
		adapter.setEnableLoadMore(true);
		adapter.setOnLoadMoreListener(() -> {
			params.page++;
			mPresenter.requestDeviceLogs(params);
		}, recyclerView);
		recyclerView.setAdapter(adapter);
</#if>
    }

    private void initListener(){

    }

    @Override
    public void onDestroyView() {
        super.onDestroyView();
        unbinder.unbind();

    }

    @Override
    public void start(Object response) {

    }

    @Override
    public void error(String errorMessage) {
        DialogHelper.warningSnackbar(getView(), errorMessage);
    }


}